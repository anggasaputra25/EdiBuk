import 'package:edibuk/pages/models.dart';
import 'package:edibuk/pages/music_play.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Bar extends StatefulWidget {
  const Bar({super.key});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<String> searchHistory = [];
  List<Book> books = [];
  List<Author> authors = [];
  List<Book> filteredBooks = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchBooks();
    fetchAuthors();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await supabase
          .from('books')
          .select('id, title, cover_image, audio, body, author_id, category_id');

      setState(() {
        books = List<Map<String, dynamic>>.from(response)
            .map((json) => Book.fromJson(json))
            .toList();
        filteredBooks = books; // Supaya default semua tampil (optional)
      });
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  Future<void> fetchAuthors() async {
    try {
      final response = await supabase
          .from('authors')
          .select('id, name, image');

      setState(() {
        authors = List<Map<String, dynamic>>.from(response)
            .map((json) => Author.fromJson(json))
            .toList();
      });
    } catch (e) {
      print('Error fetching authors: $e');
    }
  }

  void searchBooks(String query) {
    setState(() {
      searchText = query;
      filteredBooks = books
          .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void saveSearchHistory(String query) {
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      setState(() {
        searchHistory.insert(0, query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pencarian',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: IconButton(
                          icon: Icon(CupertinoIcons.bell, color: Colors.grey.shade400),
                          onPressed: () {},
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      Positioned(
                        right: 14,
                        top: 12,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6467F6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  searchBooks(value);
                },
                onSubmitted: (value) {
                  saveSearchHistory(value);
                },
                decoration: InputDecoration(
                  hintText: 'Cari buku',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600, 
                  ),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.grey.shade400, 
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Color.fromARGB(20, 6, 14, 0), 
                    ),
                  ),
                  focusedBorder: OutlineInputBorder( 
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Color.fromARGB(20, 6, 14, 0), 
                    ),
                  ),
                  enabledBorder: OutlineInputBorder( 
                    borderRadius: BorderRadius.circular(9),
                    borderSide: BorderSide(
                      color: Color.fromARGB(20, 6, 14, 0), 
                    ),
                  ),
                  filled: false,
                ),
              ),
              const SizedBox(height: 20),
              if (searchHistory.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Riwayat Pencarian",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => setState(() => searchHistory.clear()),
                      child: Text("Hapus", style: TextStyle(color: Colors.grey.shade600)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
              Expanded(
                child: searchText.isEmpty
                    ? ListView.builder(
                        itemCount: searchHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(CupertinoIcons.search, color: Colors.grey.shade400),
                            title: Text(searchHistory[index]),
                            onTap: () {
                              searchBooks(searchHistory[index]);
                            },
                            trailing: IconButton(
                              icon: Icon(CupertinoIcons.xmark, size: 20, color: Colors.grey.shade400),
                              onPressed: () {
                                setState(() {
                                  searchHistory.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      )
                    : filteredBooks.isEmpty
                        ? const Center(child: Text("Buku tidak ditemukan"))
                        : ListView.builder(
                            itemCount: filteredBooks.length,
                            itemBuilder: (context, index) {
                              final book = filteredBooks[index];
                              final author = authors.firstWhere(
                                (a) => a.id == book.authorId,
                                orElse: () => Author(id: '', name: 'Unknown', image: ''),
                              );
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MusicPlay(
                                        imageUrl: book.coverImage,
                                        title: book.title,
                                        author: author.name,
                                        audio: book.audio,
                                        body: book.body,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          book.coverImage,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              book.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              author.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );

                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
