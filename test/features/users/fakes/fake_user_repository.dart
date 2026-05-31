import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/repositories/user_repository.dart';

class FakeUserRepository implements UserRepository {
  final List<UserEntity> _users;
  String? failureMessage;

  FakeUserRepository({
    List<UserEntity> initialUsers = const [],
    this.failureMessage,
  }) : _users = List<UserEntity>.of(initialUsers);

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    if (failureMessage != null) {
      return Result.failure(failureMessage!);
    }

    return Result.success(List<UserEntity>.unmodifiable(_users));
  }

  @override
  Future<Result<void>> createUser({
    required String name,
    required String email,
  }) async {
    if (failureMessage != null) {
      return Result.failure(failureMessage!);
    }

    _users.add(UserEntity(id: _nextId, name: name, email: email));
    return Result.success(null);
  }

  @override
  Future<Result<void>> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    if (failureMessage != null) {
      return Result.failure(failureMessage!);
    }

    final index = _users.indexWhere((user) => user.id == id);
    if (index >= 0) {
      _users[index] = UserEntity(id: id, name: name, email: email);
    }
    return Result.success(null);
  }

  @override
  Future<Result<void>> deleteUser(int id) async {
    if (failureMessage != null) {
      return Result.failure(failureMessage!);
    }

    _users.removeWhere((user) => user.id == id);
    return Result.success(null);
  }

  int get _nextId {
    if (_users.isEmpty) {
      return 1;
    }
    return _users.map((user) => user.id).reduce((a, b) => a > b ? a : b) + 1;
  }
}
