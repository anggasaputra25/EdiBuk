import 'package:edibuk/pages/bar.dart';
import 'package:edibuk/pages/playlist.dart';
import 'package:edibuk/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; 

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
                        const Text(
                          'Halo Mangde 👋',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  readOnly: true, 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Bar()),
                    );
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
                _buildHorizontalSwiper([
                  ['assets/hindia1.png','Kita Ke Sana', 'Hindia'], 
                  ['assets/hindia1.png','7 Years', 'Lukas Graham'], 
                  ['assets/hindia1.png','Someone Like You', 'Adele']
                ]),
                const SizedBox(height: 20),
                _buildSectionTitle('Penulis Terpopuler'),
                _buildCircularList([
                  ['Hindia','assets/hindia1.png'], 
                  ['Oasis','assets/oasis.png'], 
                  ['Green Day','assets/hindia1.png'], 
                  ['Dewa 19','assets/dewa19.png'], 
                  ['The Beatles','assets/hindia1.png'],
                  ]),
                const SizedBox(height: 20),
                _buildSectionTitle('Buku Terpopuler'),
                _buildVerticalList([
                  ['assets/oasis.png','Stop Crying Your Heart Out', 'Oasis'],
                  ['assets/oasis.png','Champagne Supernova', 'Oasis'],
                  ['assets/hindia1.png','Wake Me Up When September Ends', 'Green Day'],
                ]),
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
          Text(  
            'Lihat Semua',  
            style: TextStyle(color: Colors.grey.shade600),  
          ),  
        ],  
      ),  
    );  
  }  

  Widget _buildHorizontalSwiper(List<List<String>> items) {
    return SizedBox(
      height: 70, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 2.3, 
            padding: const EdgeInsets.only(right: 10), 
            child: Container(
              width: 120,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(  
                color: Colors.transparent, 
                borderRadius: BorderRadius.circular(9),  
                border: Border.all(
                  color: const Color.fromARGB(20, 6, 14, 0),
                ),
              ), 
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4), 
                    child: Image.asset(
                      items[index][0],
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
                          items[index][1], 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          items[index][2], 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircularList(List<List<String>> items) {
    return SizedBox(
      height: 100, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 4.6, 
            padding: const EdgeInsets.only(right: 10), 
            child: Column(
              children: [
                CircleAvatar( 
                  radius: 30,
                  backgroundImage: AssetImage(items[index][1]),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60,
                  child: Text(
                    items[index][0],
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

  Widget _buildVerticalList(List<List<String>> items) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4), 
                child: Image.asset(
                  item[0],
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
                      item[1], 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item[1], 
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
                onPressed: () {
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

}
