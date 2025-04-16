import 'package:edibuk/models/author.dart';
import 'package:edibuk/models/book.dart';
import 'package:edibuk/repositories/author.dart';
import 'package:edibuk/repositories/book.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BarViewModel extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  final BookRepository _bookRepository = BookRepository();
  final AuthorRepository _authorRepository = AuthorRepository();

  List<String> searchHistory = [];
  List<Book> books = [];
  List<Author> authors = [];
  List<Book> filteredBooks = [];
  String searchText = '';

  BarViewModel() {
    loadBarData();
  }

  Future<void> loadBarData() async {
    books = await _bookRepository.fetchBooks();
    authors = await _authorRepository.fetchAuthors();
    notifyListeners();
  }

  void searchBooks(String query) {
    searchText = query;
    filteredBooks =
        books
            .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
  }

  void saveSearchHistory(String query) {
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      searchHistory.insert(0, query);
      notifyListeners();
    }
  }

  void clearHistory() {
    searchHistory.clear();
    notifyListeners();
  }

  void removeHistoryAt(int index) {
    searchHistory.removeAt(index);
    notifyListeners();
  }

  Author getAuthorById(String id) {
    return authors.firstWhere(
      (a) => a.id == id,
      orElse: () => Author(id: '', name: 'Unknown', image: ''),
    );
  }
}
