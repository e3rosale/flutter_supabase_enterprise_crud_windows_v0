import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Result<List<UserEntity>>> call() {
    return repository.getUsers();
  }
}
