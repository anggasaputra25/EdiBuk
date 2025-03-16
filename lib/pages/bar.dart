
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  const Bar({super.key});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {

  List<String> searchHistory = [
    "Oasis", "Hindia", "Dewa 19"
  ];

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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color.fromARGB(20, 6, 14, 0)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Riwayat Pencarian",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        searchHistory.clear();
                      });
                    },
                    child: Text(
                      "Hapus",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0), 
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 8), 
                        child: const Icon(CupertinoIcons.search, size: 22),
                      ),
                      title: Text(searchHistory[index]),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 8), 
                        child: IconButton(
                          icon: const Icon(CupertinoIcons.xmark, size: 20),
                          onPressed: () {
                            setState(() {
                              searchHistory.removeAt(index);
                            });
                          },
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
