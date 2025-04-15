import 'package:edibuk/viewmodels/search.dart';
import 'package:edibuk/views/bar.dart';
import 'package:edibuk/widgets/navigation_bar.dart';
import 'package:edibuk/widgets/notification_icon.dart';
import 'package:edibuk/widgets/search_input.dart';
import 'package:edibuk/widgets/book_card.dart';
import 'package:edibuk/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edibuk/pages/book_play.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: const SearchPageContent(),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SearchViewModel>(context);

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
                _buildHeader(),
                const SizedBox(height: 16),
                SearchInput(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Bar()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildSectionTitle("Terpopuler Juli", onTap: () {}),
                _buildPopularBooks(vm),
                const SizedBox(height: 20),
                _buildSectionTitle("Jelajahi Kategori Buku"),
                _buildCategories(vm),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Pencarian',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        NotificationIcon(),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: const Text(
                "Lihat Semua",
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPopularBooks(SearchViewModel vm) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vm.books.take(4).length,
        itemBuilder: (context, index) {
          final book = vm.books[index];
          return Container(
            width: MediaQuery.of(context).size.width / 4,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: BookCardSearchPage(
              book: book,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BookPlay(
                            imageUrl: book.coverImage ?? '/',
                            title: book.title,
                            author: book.authorName,
                            audio: book.audio,
                            body: book.body,
                          ),
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories(SearchViewModel vm) {
    if (vm.categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vm.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final category = vm.categories[index];
        final book = vm.books.firstWhere(
          (book) => book.categoryId == category.id,
          orElse: () => vm.emptyBook,
        );
        return CategoryCard(title: category.name, imageUrl: book.coverImage);
      },
    );
  }
}
