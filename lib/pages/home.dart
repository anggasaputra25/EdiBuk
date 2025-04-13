import 'package:edibuk/pages/bar.dart';
import 'package:edibuk/pages/models.dart';
import 'package:edibuk/pages/book_play.dart';
import 'package:edibuk/pages/playlist.dart';
import 'package:edibuk/pages/profile.dart';
import 'package:edibuk/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Book> books = [];
  List<Author> authors = [];
  String? username;

  @override
  void initState() {
    super.initState();
    fetchBooks();
    fetchAuthors();
    fetchUser();
  }

  void fetchUser() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      username = user?.userMetadata?['name'] ?? user?.email ?? 'Pengguna';
    });
  }

  Future<void> fetchBooks() async {
    try {
      final response = await Supabase.instance.client
          .from('books')
          .select(
            'id, title, cover_image, audio, body, author_id, category_id, authors(name)',
          );

      setState(() {
        books =
            List<Map<String, dynamic>>.from(
              response,
            ).map((json) => Book.fromJson(json)).toList();
      });
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  Future<void> fetchAuthors() async {
    try {
      final response = await Supabase.instance.client
          .from('authors')
          .select('id, name, image');

      setState(() {
        authors =
            List<Map<String, dynamic>>.from(
              response,
            ).map((json) => Author.fromJson(json)).toList();
      });
      print('Fetched authors: $response');
    } catch (e) {
      print('Error fetching authors: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo ${username ?? ''} 👋',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Dengarkan bukumu hari ini!',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.bell,
                              color: Colors.grey.shade400,
                            ),
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
                              color: Color(0xFF6467F6),
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
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Bar()),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari buku',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey.shade400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(20, 6, 14, 0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(20, 6, 14, 0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(20, 6, 14, 0),
                      ),
                    ),
                    filled: false,
                  ),
                ),
                const SizedBox(height: 20),

                _buildSectionTitle('Baru Diputar'),
                _buildHorizontalSwiper(context, books),
                const SizedBox(height: 20),

                _buildSectionTitle('Penulis Terpopuler'),
                _buildCircularList(authors),
                const SizedBox(height: 20),

                _buildSectionTitle('Buku Terpopuler'),
                _buildVerticalList(books),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index != _selectedIndex) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlaylistPage()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            }
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ''),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note_list),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: ''),
        ],
        selectedItemColor: const Color(0xFF6467F6),
        unselectedItemColor: Colors.grey.shade300,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Lihat Semua', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildHorizontalSwiper(BuildContext context, List<Book> books) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BookPlay(
                        imageUrl: books[index].coverImage,
                        title: books[index].title,
                        author: books[index].authorName,
                        audio: books[index].audio,
                        body: books[index].body,
                      ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.3,
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: const Color.fromARGB(20, 6, 14, 0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        books[index].coverImage,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            books[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            books[index].authorName,

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
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircularList(List<Author> authors) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: authors.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 4.6,
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(authors[index].image),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60,
                  child: Text(
                    authors[index].name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalList(List<Book> books) {
    return Column(
      children:
          books.map((book) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BookPlay(
                          imageUrl: book.coverImage,
                          title: book.title,
                          author: book.authorName,
                          audio: book.audio,
                          body: book.body,
                        ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            book.authorName,
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
                    IconButton(
                      icon: const Icon(CupertinoIcons.ellipsis_vertical),
                      iconSize: 24,
                      color: Colors.grey.shade400,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
