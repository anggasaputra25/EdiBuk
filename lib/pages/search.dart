import 'package:edibuk/pages/home.dart';
import 'package:edibuk/pages/playlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edibuk/pages/profile.dart';

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
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
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
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final items = [
                      ['assets/oasis.png', 'Stop Crying...', 'Oasis'],
                      ['assets/hindia1.png', 'Berdansalah...', 'Hindia'],
                      ['assets/hindia2.png', 'Ramai Sepi...', 'Hindia'],
                      ['assets/dewa19.png', 'Kangen', 'Dewa 19'],
                    ];
                    return Container(
                      width: MediaQuery.of(context).size.width / 4, 
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: _buildPopularItem(items[index][0], items[index][1], items[index][2]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Jelajahi Kategori Musik",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), 
                crossAxisCount: 3,
                childAspectRatio: 1,
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
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.music_note_list), label: ''),
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

  Widget _buildPopularItem(String image, String title, String artist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, height: 90, width: 120, fit: BoxFit.cover),
        ),
        const SizedBox(height: 5),
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(artist, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCategoryItem(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF6467F6),
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter, 
            child: Image.asset(image, height: 60, width: 80, fit: BoxFit.cover),
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
