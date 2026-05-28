import 'package:flutter/foundation.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/usecases/create_user.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/usecases/get_users.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/usecases/update_user.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/presentation/viewmodels/user_operation_result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/presentation/viewmodels/users_state.dart';

// import '../../domain/usecases/delete_user.dart';
// import '../../domain/usecases/update_user.dart';

class UsersViewModel extends ChangeNotifier {
  final GetUsers getUsersUseCase;
  final CreateUser createUserUseCase;
  final UpdateUser updateUserUseCase;
  final DeleteUser deleteUserUseCase;

  UsersViewModel({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  });

  UsersState _state = const UsersState();

  UsersState get state => _state;

  Future<void> loadUsers() async {
    _setState(_state.copyWith(isLoading: true, clearError: true));

    await _reloadUsers();

    _setState(_state.copyWith(isLoading: false));
  }

  Future<UserOperationResult> createUser({
    required String name,
    required String email,
  }) async {
    _setState(_state.copyWith(isLoading: true, clearError: true));

    final result = await createUserUseCase(name: name, email: email);

    if (result.isFailure) {
      _setState(_state.copyWith(isLoading: false, errorMessage: result.error));

      return UserOperationResult.mutationFailed(result.error);
    }

    final reloadResult = await _reloadUsers();

    _setState(_state.copyWith(isLoading: false));

    return reloadResult;
  }

  Future<UserOperationResult> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    _setState(_state.copyWith(isLoading: true, clearError: true));

    final result = await updateUserUseCase(id: id, name: name, email: email);

    if (result.isFailure) {
      _setState(_state.copyWith(isLoading: false, errorMessage: result.error));

      return UserOperationResult.mutationFailed(result.error);
    }

    final reloadResult = await _reloadUsers();

    _setState(_state.copyWith(isLoading: false));

    return reloadResult;
  }

  Future<UserOperationResult> deleteUser(int id) async {
    _setState(_state.copyWith(isLoading: true, clearError: true));

    final result = await deleteUserUseCase(id);

    if (result.isFailure) {
      _setState(_state.copyWith(isLoading: false, errorMessage: result.error));

      return UserOperationResult.mutationFailed(result.error);
    }

    final reloadResult = await _reloadUsers();

    _setState(_state.copyWith(isLoading: false));

    return reloadResult;
  }

  Future<UserOperationResult> _reloadUsers() async {
    final Result<List<UserEntity>> result = await getUsersUseCase();

    if (result.isFailure) {
      _setState(_state.copyWith(errorMessage: result.error));

      return UserOperationResult.reloadFailed(result.error);
    }

    _setState(_state.copyWith(users: result.data!, clearError: true));

    return UserOperationResult.success();
  }

  void _setState(UsersState newState) {
    if (_state == newState) return;

    _state = newState;
    notifyListeners();
  }
}
