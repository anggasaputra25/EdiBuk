import 'package:edibuk/viewmodels/home.dart';
import 'package:edibuk/views/bar.dart';
import 'package:edibuk/widgets/author_card.dart';
import 'package:edibuk/widgets/book_card.dart';
import 'package:edibuk/widgets/navigation_bar.dart';
import 'package:edibuk/widgets/notification_icon.dart';
import 'package:edibuk/widgets/search_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const HomePageContent(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildHeader(viewModel),
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
                _buildSectionTitle('Baru Diputar'),
                BookSwiper(books: viewModel.books),
                const SizedBox(height: 20),
                _buildSectionTitle('Penulis Terpopuler'),
                AuthorList(authors: viewModel.authors),
                const SizedBox(height: 20),
                _buildSectionTitle('Buku Terpopuler'),
                BookVerticalList(books: viewModel.books),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader(HomeViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo ${vm.username ?? ''} 👋',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Dengarkan bukumu hari ini!',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
        const NotificationIcon(),
      ],
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
          Text('Lihat Semua', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
