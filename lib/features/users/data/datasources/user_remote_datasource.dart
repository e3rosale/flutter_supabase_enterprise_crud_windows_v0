import 'package:flutter_supabase_enterprise_crud_windows_v0/core/error/app_exception.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRemoteDataSource {
  final SupabaseClient client;

  UserRemoteDataSource(this.client);

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client
          .from('users')
          .select()
          .order('id', ascending: true);

      return (response as List)
          .map((item) => UserModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw AppException('Failed to fetch users: $e');
    }
  }

  Future<void> createUser({required String name, required String email}) async {
    try {
      await client.from('users').insert({'name': name, 'email': email});
    } catch (e) {
      throw AppException('Failed to create user: $e');
    }
  }

  Future<void> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    try {
      await client
          .from('users')
          .update({'name': name, 'email': email})
          .eq('id', id);
    } catch (e) {
      throw AppException('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await client.from('users').delete().eq('id', id);
    } catch (e) {
      throw AppException('Failed to delete user: $e');
    }
  }
}
