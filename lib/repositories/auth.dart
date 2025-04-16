import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<String?> fetchUsername() async {
    final user = _client.auth.currentUser;
    return user?.userMetadata?['name'] ?? user?.email ?? 'Pengguna';
  }
}
