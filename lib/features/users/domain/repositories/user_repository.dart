import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Result<List<UserEntity>>> getUsers();

  Future<Result<void>> createUsers({
    required String name,
    required String email,
  });

  Future<Result<void>> updateUser({
    required int id,
    required String name,
    required String email,
  });

  Future<Result<void>> deleteUser(int id);
}
