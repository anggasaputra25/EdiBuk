import 'package:edibuk/pages/bar.dart';
import 'package:edibuk/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromARGB(20, 6, 14, 0),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.bell),
                        onPressed: () {},
                        iconSize: 24,
                        padding: EdgeInsets.zero,
                      ),
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
                      prefixIcon: const Icon(CupertinoIcons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color.fromARGB(20, 6, 14, 0), 
                        ),
                      ),
                      focusedBorder: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color.fromARGB(20, 6, 14, 0), 
                        ),
                      ),
                      enabledBorder: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color.fromARGB(20, 6, 14, 0), 
                        ),
                      ),
                      filled: false,
                    ),
                  ),

                const SizedBox(height: 20),
                _buildSectionTitle('Baru Diputar'),
                _buildHorizontalList([
                  ['Kita Ke Sana','Hindia'], 
                  ['7 Years','Lukas Graham'], 
                  ['Someone Like You','Adele']
                ]),
                const SizedBox(height: 20),
                _buildSectionTitle('Penulis Terpopuler'),
                _buildCircularList(['Hindia', 'Oasis', 'Green Day', 'Dewa 19', 'The Beatles']),
                const SizedBox(height: 20),
                _buildSectionTitle('Buku Terpopuler'),
                _buildVerticalList([
                  ['Stop Crying Your Heart Out','Oasis'],
                  ['Champagne Supernova','Oasis'],
                  ['Wake Me Up When September Ends','Green Day'],
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
              Navigator.pushReplacementNamed(context, '/'); 
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
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

  Widget _buildHorizontalList(List<List<String>> items) {  
    return SizedBox(
      height: 70,
      child: CarouselSlider.builder(
        itemCount: items.length,
        slideBuilder: (index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 16), 
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(  
              color: Colors.transparent, 
              borderRadius: BorderRadius.circular(12),  
              border: Border.all(  
                color: Color.fromARGB(20, 6, 14, 0), 
              ),
            ), 
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index][0], 
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        items[index][1], 
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
          );
        },
        enableAutoSlider: false,
        viewportFraction: 0.6, 
        initialPage: 0,
      ),
    );
  }

  Widget _buildCircularList(List<String> items) {
    return SizedBox(
      height: 120,
      child: CarouselSlider.builder(
        slideBuilder: (index) {
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 60,
                child: Text(
                  items[index],
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
          );
        },
        itemCount: items.length,
        enableAutoSlider: false,
        viewportFraction: 0.24,
        initialPage: 0,
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item[0], 
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
            ],
          ),
        );
      }).toList(),
    );
  }

}
