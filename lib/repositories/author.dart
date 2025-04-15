import 'package:edibuk/models/author.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthorRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Author>> fetchAuthors() async {
    final response = await _client.from('authors').select('id, name, image');
    return List<Map<String, dynamic>>.from(
      response,
    ).map((json) => Author.fromJson(json)).toList();
  }
}
