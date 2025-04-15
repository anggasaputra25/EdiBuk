import 'package:edibuk/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edibuk/views/search.dart';
import 'package:edibuk/pages/playlist.dart';
import 'package:edibuk/pages/profile.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0: Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage())); break;
          case 1: Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage())); break;
          case 2: Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaylistPage())); break;
          case 3: Navigator.push(context, MaterialPageRoute(builder: (_) => const Profile())); break;
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
    );
  }
}
