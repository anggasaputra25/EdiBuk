import 'package:edibuk/models/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Category>> fetchCategories() async {
    final response = await _client
        .from('categories')
        .select(
          'id, name',
        );

    return List<Map<String, dynamic>>.from(
      response,
    ).map((json) => Category.fromJson(json)).toList();
  }
}
