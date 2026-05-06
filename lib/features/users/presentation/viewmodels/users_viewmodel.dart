import 'package:flutter/foundation.dart';

import '../../../../core/utils/result.dart';
import 'user_operation_result.dart';
// import '../../domain/entities/user_entity.dart';
// import '../../domain/usecases/create_user.dart';
// import '../../domain/usecases/delete_user.dart';
// import '../../domain/usecases/get_users.dart';
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

  List<UserEntity> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<UserEntity> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadUsers() async {
    _setLoading(true);
    _errorMessage = null;

    await _reloadUsers();

    _setLoading(false);
  }

  Future<UserOperationResult> createUser({
    required String name,
    required String email,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await createUserUseCase(name: name, email: email);

    if (result.isFailure) {
      _errorMessage = result.error;
      _setLoading(false);
      return UserOperationResult.mutationFailed(result.error);
    }

    final reloadResult = await _reloadUsers();

    _setLoading(false);
    return reloadResult;
  }

  Future<UserOperationResult> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await updateUserUseCase(id: id, name: name, email: email);

    if (result.isFailure) {
      _errorMessage = result.error;
      _setLoading(false);
      return UserOperationResult.mutationFailed(result.error);
    }

    final reloadResult = await _reloadUsers();

    _setLoading(false);
    return reloadResult;
  }

  Future<UserOperationResult> deleteUser(int id) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await deleteUserUseCase(id);

    if (result.isFailure) {
      _errorMessage = result.error;
      _setLoading(false);
      return UserOperationResult.mutationFailed(result.error);
    }

    final reloadResult = await _reloadUsers();

    _setLoading(false);
    return reloadResult;
  }

  Future<UserOperationResult> _reloadUsers() async {
    final Result<List<UserEntity>> result = await getUsersUseCase();

    if (result.isFailure) {
      _errorMessage = result.error;
      return UserOperationResult.reloadFailed(result.error);
    }

    _users = result.data!;
    return UserOperationResult.success();
  }

  void _setLoading(bool value) {
    if (_isLoading == value) return;

    _isLoading = value;
    notifyListeners();
  }
}
