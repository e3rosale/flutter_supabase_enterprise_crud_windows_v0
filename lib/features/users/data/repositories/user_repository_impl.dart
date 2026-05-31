import 'package:flutter_supabase_enterprise_crud_windows_v0/core/error/app_exception.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/data/datasources/user_remote_datasource.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  Future<Result<T>> _run<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Result.success(result);
    } on AppException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unexpected error: $e');
    }
  }

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    return _run(() async {
      final userModels = await remoteDataSource.getUsers();

      return userModels.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<void>> createUser({
    required String name,
    required String email,
  }) async {
    return _run(() async {
      return remoteDataSource.createUser(name: name, email: email);
    });
  }

  @override
  Future<Result<void>> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    return _run(() async {
      return remoteDataSource.updateUser(id: id, name: name, email: email);
    });
  }

  @override
  Future<Result<void>> deleteUser(int id) async {
    return _run(() async {
      return remoteDataSource.deleteUser(id);
    });
  }
}
