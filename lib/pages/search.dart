import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pencarian',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color.fromARGB(20, 6, 14, 0),
              ),
            ),
            child: IconButton(
              icon: Stack(
                children: [
                  const Icon(CupertinoIcons.bell),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFF6467F6), 
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
                hintText: "Cari musik",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Terpopuler Juli
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
            const SizedBox(height: 10),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPopularItem('assets/oasis.png', 'Stop Crying...', 'Oasis'),
                  _buildPopularItem('assets/hindia1.png', 'Berdansalah...', 'Hindia'),
                  _buildPopularItem('assets/hindia2.png', 'Ramai Sepi...', 'Hindia'),
                  _buildPopularItem('assets/dewa19.png', 'Kangen', 'Dewa 19'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Kategori Musik
            const Text(
              "Jelajahi Kategori Musik",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildCategoryItem('Pop', 'assets/pop.png'),
                _buildCategoryItem('Rock', 'assets/rock.png'),
                _buildCategoryItem('Hip-Hop', 'assets/hiphop.png'),
                _buildCategoryItem('Jazz', 'assets/jazz.png'),
                _buildCategoryItem('Classical', 'assets/classical.png'),
                _buildCategoryItem('Blues', 'assets/blues.png'),
                _buildCategoryItem('Dance', 'assets/dance.png'),
                _buildCategoryItem('Country', 'assets/country.png'),
                _buildCategoryItem('Reggae', 'assets/reggae.png'),
              ],
            ),

          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index != _selectedIndex) { 
            setState(() {
              _selectedIndex = index;
            });
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/'); 
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/search');
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
        unselectedItemColor: Colors.grey.shade300,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  // Widget untuk item terpopuler
  Widget _buildPopularItem(String image, String title, String artist) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, height: 90, width: 120, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(artist, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // Widget untuk kategori musik
  Widget _buildCategoryItem(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF6467F6),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image, height: 40, width: 60, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
