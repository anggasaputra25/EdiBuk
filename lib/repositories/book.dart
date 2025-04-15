import 'package:edibuk/models/book.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Book>> fetchBooks() async {
    final response = await _client
        .from('books')
        .select(
          'id, title, cover_image, audio, body, author_id, category_id, authors(name)',
        );

    return List<Map<String, dynamic>>.from(
      response,
    ).map((json) => Book.fromJson(json)).toList();
  }
}
