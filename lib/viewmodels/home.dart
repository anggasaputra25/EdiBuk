import 'package:edibuk/models/author.dart';
import 'package:edibuk/models/book.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  List<Book> books = [];
  List<Author> authors = [];
  String? username;

  HomeViewModel() {
    fetchUser();
    fetchBooks();
    fetchAuthors();
  }

  void fetchUser() {
    final user = _client.auth.currentUser;
    username = user?.userMetadata?['name'] ?? user?.email ?? 'Pengguna';
    notifyListeners();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await _client
          .from('books')
          .select('id, title, cover_image, audio, body, author_id, category_id, authors(name)');
      books = List<Map<String, dynamic>>.from(response)
          .map((json) => Book.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching books: $e');
    }
  }

  Future<void> fetchAuthors() async {
    try {
      final response = await _client.from('authors').select('id, name, image');
      authors = List<Map<String, dynamic>>.from(response)
          .map((json) => Author.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching authors: $e');
    }
  }
}
