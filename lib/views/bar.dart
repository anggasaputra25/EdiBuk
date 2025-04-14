import 'package:edibuk/pages/book_play.dart';
import 'package:edibuk/viewmodels/bar.dart';
import 'package:edibuk/widgets/notification_icon.dart';
import 'package:edibuk/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BarViewModel(),
      child: const BarContent(),
    );
  }
}

class BarContent extends StatelessWidget {
  const BarContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BarViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 16),
              SearchInput(
                onChanged: vm.searchBooks,
                onSubmitted: vm.saveSearchHistory,
              ),
              const SizedBox(height: 20),
              if (vm.searchHistory.isNotEmpty) _buildSearchHistory(vm),
              Expanded(child: _buildBookList(vm)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Pencarian',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const NotificationIcon(),
      ],
    );
  }

  Widget _buildSearchHistory(BarViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Riwayat Pencarian",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: vm.clearHistory,
              child: Text(
                "Hapus",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...vm.searchHistory.map((item) {
          int index = vm.searchHistory.indexOf(item);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.search,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => vm.searchBooks(item),
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ), // bisa kamu sesuaikan
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.xmark,
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
                    onPressed: () => vm.removeHistoryAt(index),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildBookList(BarViewModel vm) {
    if (vm.searchText.isEmpty) {
      return ListView();
    } else if (vm.filteredBooks.isEmpty) {
      return const Center(child: Text("Buku tidak ditemukan"));
    }

    return ListView.builder(
      itemCount: vm.filteredBooks.length,
      itemBuilder: (context, index) {
        final book = vm.filteredBooks[index];
        final author = vm.getAuthorById(book.authorName);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => BookPlay(
                      imageUrl: book.coverImage,
                      title: book.title,
                      author: author.name,
                      audio: book.audio,
                      body: book.body,
                    ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
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
                        author.name,
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
        );
      },
    );
  }
}
