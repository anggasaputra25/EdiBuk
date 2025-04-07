import 'package:edibuk/pages/home.dart';
import 'package:edibuk/pages/models.dart';
import 'package:edibuk/pages/playlist.dart';
import 'package:edibuk/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {  
  int _selectedIndex = 1;  
  List<Book> books = [];  
  List<Category> categories = [];  
  Map<String, String> authorNames = {}; 

  @override  
  void initState() {  
    super.initState();  
    fetchBooks();  
    fetchCategories();  
  }  

  Future<void> fetchBooks() async {  
    try {  
      final response = await Supabase.instance.client  
          .from('books')  
          .select('id, title, cover_image, audio, body, author_id, category_id, authors(name)'); // Fetching author name  

      setState(() {  
        books = List<Map<String, dynamic>>.from(response)  
            .map((json) => Book.fromJson(json))  
            .toList();  

        for (var item in response) {  
          if (item['authors'] != null) {  
            authorNames[item['author_id']] = item['authors']['name'];  
          }  
        }  
      });  
    } catch (e) {  
      print('Error fetching books: $e');  
    }  
  }  

  Future<void> fetchCategories() async {
    try {
      final response = await Supabase.instance.client
          .from('categories')
          .select('id, name');

      print('Categories fetched: $response');

      setState(() {
        categories = List<Map<String, dynamic>>.from(response)
            .map((json) => Category.fromJson(json))
            .toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
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
                            decoration: const BoxDecoration(  
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
                  decoration: InputDecoration(  
                    hintText: 'Cari buku',  
                    hintStyle: TextStyle(color: Colors.grey.shade600),  
                    prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey.shade400),  
                    border: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(9),  
                      borderSide: const BorderSide(color: Color.fromARGB(20, 6, 14, 0)),  
                    ),  
                    focusedBorder: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(9),  
                      borderSide: const BorderSide(color: Color.fromARGB(20, 6, 14, 0)),  
                    ),  
                    enabledBorder: OutlineInputBorder(  
                      borderRadius: BorderRadius.circular(9),  
                      borderSide: const BorderSide(color: Color.fromARGB(20, 6, 14, 0)),  
                    ),  
                    filled: false,  
                  ),  
                ),  
                const SizedBox(height: 20),  
                Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                  children: [  
                    const Text(  
                      "Terpopuler Juli",  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                    ),  
                    TextButton(  
                      onPressed: () {},  
                      child: const Text("Lihat Semua", style: TextStyle(color: Colors.grey)),  
                    ),  
                  ],  
                ),  
                const SizedBox(height: 0),  
                SizedBox(  
                  height: 140,  
                  child: ListView.builder(  
                    scrollDirection: Axis.horizontal,  
                    itemCount: books.length > 4 ? 4 : books.length,  
                    itemBuilder: (context, index) {  
                      final book = books[index];  
                      final authorName = authorNames[book.authorId] ?? 'Unknown Author'; // Get author name  
                      return Container(  
                        width: MediaQuery.of(context).size.width / 4,  
                        padding: const EdgeInsets.symmetric(horizontal: 5),  
                        child: _buildPopularItem(book.coverImage ?? '/', book.title, authorName), // Pass author name  
                      );  
                    }  
                  ),  
                ),  
                const SizedBox(height: 20),  
                const Text(  
                  "Jelajahi Kategori Buku",  
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                ),  
                const SizedBox(height: 10),  
                categories.isEmpty  
                    ? const Center(child: CircularProgressIndicator())  
                    : GridView.builder(  
                        shrinkWrap: true,  
                        physics: const NeverScrollableScrollPhysics(),  
                        itemCount: categories.length,  
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
                          crossAxisCount: 3,  
                          crossAxisSpacing: 10,  
                          mainAxisSpacing: 10,  
                          childAspectRatio: 1,  
                        ),  
                        itemBuilder: (context, index) {  
                          final category = categories[index];  

                          final bookCoverImage = books
                            .firstWhere(
                              (book) => book.categoryId.toString() == category.id.toString(), // Fix type mismatch
                              orElse: () => Book(id: '', coverImage: '', title: '', body: '', audio: '', authorId: '', categoryId: '')
                            )
                            .coverImage;


                          return _buildCategoryItem(category.name, bookCoverImage);  
                        },  
                      ),  
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));  
            } else if (index == 1) {  
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));  
            } else if (index == 2) {  
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PlaylistPage()));  
            } else if (index == 3) {  
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));  
            }  
          }  
        },  
        items: const [  
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ''),  
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ''),  
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.music_note_list), label: ''),  
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: ''),  
        ],  
        selectedItemColor: const Color(0xFF6467F6),  
        unselectedItemColor: Colors.grey,  
        showSelectedLabels: false,  
        showUnselectedLabels: false,  
        selectedFontSize: 0,  
        unselectedFontSize: 0,  
      ),  
    );  
  }  

  Widget _buildPopularItem(String imageUrl, String title, String author) {  
    return Column(  
      crossAxisAlignment: CrossAxisAlignment.start,  
      children: [  
        ClipRRect(  
          borderRadius: BorderRadius.circular(9),  
          child: Image.network(  
            imageUrl,  
            height: 90,  
            width: 120,  
            fit: BoxFit.cover,  
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),  
          ),  
        ),  
        const SizedBox(height: 5),  
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),  
        Text(author, style: const TextStyle(fontSize: 12, color: Colors.grey)),  
      ],  
    );  
  }  

  Widget _buildCategoryItem(String title, String? imageUrl) {  
    return Container(  
      decoration: BoxDecoration(  
        color: const Color(0xFF6467F6),  
        borderRadius: BorderRadius.circular(9),  
      ),  
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),  
      child: Stack(  
        children: [  
          if (imageUrl != null)  
            Align(  
              alignment: Alignment.bottomCenter,  
              child: Image.network(  
                imageUrl,  
                height: 60,  
                width: 80,  
                fit: BoxFit.cover,  
                errorBuilder: (context, error, stackTrace) {  
                  return const Icon(Icons.image_not_supported, color: Colors.white);  
                },  
              ),  
            ),  
          Positioned(  
            left: 4,  
            child: Text(  
              title,  
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),  
            ),  
          ),  
        ],  
      ),  
    );  
  }  
}  