import 'package:edibuk/pages/home.dart';  
import 'package:edibuk/pages/search.dart';  
import 'package:flutter/cupertino.dart';  
import 'package:flutter/material.dart';  

class PlaylistPage extends StatefulWidget {  
  const PlaylistPage({super.key});  

  @override  
  State<PlaylistPage> createState() => _PlaylistPageState();  
}  

class _PlaylistPageState extends State<PlaylistPage> {  
  int _selectedIndex = 2;   

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
                      'Koleksi Playlist',  
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
                const SizedBox(height: 20),  
                Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                  children: [  
                    const Text(  
                      "Playlist Anda",  
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                    ),  
                    Row(  
                      children: [  
                        IconButton(  
                          icon: const Icon(CupertinoIcons.plus),  
                          iconSize: 24,  
                          color: Colors.grey.shade400,  
                          onPressed: () {},  
                        ),  
                        IconButton(  
                          icon: const Icon(CupertinoIcons.sort_down),  
                          iconSize: 24,  
                          color: Colors.grey.shade400,  
                          onPressed: () {},  
                        ),  
                      ],  
                    ),  
                  ],  
                ),  
                _buildVerticalList([  
                  ['assets/oasis.png', 'Stop Crying Your Heart Out', 'Oasis'],  
                  ['assets/oasis.png', 'Champagne Supernova', 'Oasis'],  
                  ['assets/hindia1.png', 'Wake Me Up When September Ends', 'Green Day'],  
                ]),  
                const SizedBox(height: 20),  
                const Text(  
                  "Buku Yang Anda Sukai",  
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                ),  
                const SizedBox(height: 12),  
                _buildPlayList([]), 
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
                      item[2],   
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
        );  
      }).toList(),  
    );  
  }  

  Widget _buildPlayList(List<List<String>> items) {  
    return Row(  
      crossAxisAlignment: CrossAxisAlignment.center,  
      children: [  
        Container(  
          padding: const EdgeInsets.all(8),  
          decoration: BoxDecoration(  
            color: const Color(0xFF6467F6),  
            borderRadius: BorderRadius.circular(9),  
          ),  
          width: 50,
          height: 50,
          child: const Icon(  
            Icons.favorite,  
            color: Colors.white,  
            size: 24,  
          ),  
        ),  
        const SizedBox(width: 12),  
        const Expanded(  
          child: Text(  
            "Buku yang Disukai",  
            style: TextStyle(  
              fontSize: 16,  
              fontWeight: FontWeight.bold,  
            ),  
          ),  
        ),  
      ],  
    );  
  }

}  