import 'package:flutter_supabase_enterprise_crud_windows_v0/core/error/app_exception.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/data/datasources/user_remote_datasource.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return Result.success(users);
    } on AppException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unexpected error: $e');
    }
  }

  @override
  Future<Result<void>> createUser({
    required String name,
    required String email,
  }) async {
    try {
      await remoteDataSource.createUser(name: name, email: email);
      return Result.success(null);
    } on AppException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unexpected error: $e');
    }
  }

  @override
  Future<Result<void>> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    try {
      await remoteDataSource.updateUser(id: id, name: name, email: email);
      return Result.success(null);
    } on AppException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unexpected error: $e');
    }
  }

  @override
  Future<Result<void>> deleteUser(int id) async {
    try {
      await remoteDataSource.deleteUser(id);
      return Result.success(null);
    } on AppException catch (e) {
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure('Unexpected error: $e');
    }
  }
}
