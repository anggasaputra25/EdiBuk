import 'package:edibuk/pages/home.dart';
import 'package:edibuk/pages/playlist.dart';
import 'package:edibuk/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaylistDetailPage extends StatefulWidget {
  final String imagePath;
  final String playlistName;
  final String songCount;

  const PlaylistDetailPage({
    super.key,
    required this.imagePath,
    required this.playlistName,
    required this.songCount,
  });

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {

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
                    Container(  
                      decoration: BoxDecoration(  
                        borderRadius: BorderRadius.circular(9),  
                        border: Border.all(color: Colors.black12),  
                      ),  
                      child: IconButton(  
                        icon: Icon(CupertinoIcons.arrow_left, color: Colors.grey.shade400),  
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const PlaylistPage()),  
                          );
                        },  
                        iconSize: 24,  
                        padding: EdgeInsets.zero,  
                      ),  
                    ),  
                    const Text(  
                      'Playlist',  
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),  
                    ),  
                    Container(  
                      decoration: BoxDecoration(  
                        borderRadius: BorderRadius.circular(9),  
                        border: Border.all(color: Colors.black12),  
                      ),  
                      child: IconButton(  
                        icon: Icon(CupertinoIcons.ellipsis_vertical, color: Colors.grey.shade400),  
                        onPressed: () {},  
                        iconSize: 24,  
                        padding: EdgeInsets.zero,  
                      ),  
                    ),  
                  ],  
                ),  
                const SizedBox(height: 20),  
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset(
                        widget.imagePath,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.playlistName,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Playlist • ${widget.songCount} Buku',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6467F6),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12), 
                              ),
                              child: const Icon(
                                CupertinoIcons.play_fill,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 1), 
                            const Text(
                              'Putar Buku',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6467F6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(CupertinoIcons.add, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Tambahkan buku ke playlist ini',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildVerticalList([
                  ['assets/oasis.png', '7 Years', 'Lukas Graham'],
                  ['assets/hindia1.png', 'Ramai Sepi Bersama', 'Hindia'],
                  ['assets/oasis.png', 'Stop Crying Your Heart Out', 'Oasis'],
                  ['assets/oasis.png', 'Champagne Supernova', 'Oasis'],
                  ['assets/oasis.png', 'Wake Me Up When September Ends', 'Green Day'],
                  ['assets/hindia2.png', 'Kita Ke Sana', 'Hindia'],
                ]),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(  
        type: BottomNavigationBarType.fixed,   
        currentIndex: 2,  
        onTap: (index) {  
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
}
