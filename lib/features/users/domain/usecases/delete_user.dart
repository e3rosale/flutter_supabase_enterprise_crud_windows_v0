import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/repositories/user_repository.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<Result<void>> call(int id) {
    if (id <= 0) {
      return Future.value(Result.failure('User id must be valid.'));
    }

    return repository.deleteUser(id);
  }
}
