import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/book.dart';
import '../models/author.dart';

class BarViewModel extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  List<String> searchHistory = [];
  List<Book> books = [];
  List<Author> authors = [];
  List<Book> filteredBooks = [];
  String searchText = '';

  BarViewModel() {
    fetchBooks();
    fetchAuthors();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await supabase
          .from('books')
          .select('id, title, cover_image, audio, body, author_id, category_id, authors(name)');
      books = List<Map<String, dynamic>>.from(response).map(Book.fromJson).toList();
      filteredBooks = books;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> fetchAuthors() async {
    try {
      final response = await supabase.from('authors').select('id, name, image');
      authors = List<Map<String, dynamic>>.from(response).map(Author.fromJson).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching authors: $e');
    }
  }

  void searchBooks(String query) {
    searchText = query;
    filteredBooks = books
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
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
    return authors.firstWhere((a) => a.id == id, orElse: () => Author(id: '', name: 'Unknown', image: ''));
  }
}
