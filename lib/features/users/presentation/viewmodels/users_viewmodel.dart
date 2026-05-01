import 'package:flutter/foundation.dart';

import '../../../../core/utils/result.dart';
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

    final Result<List<UserEntity>> result = await getUsersUseCase();

    if (result.isSuccess) {
      _users = result.data ?? [];
    } else {
      _errorMessage = result.error;
    }

    _setLoading(false);
  }

  Future<bool> createUser({required String name, required String email}) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await createUserUseCase(name: name, email: email);

    if (result.isFailure) {
      _errorMessage = result.error;
      _setLoading(false);
      return false;
    }

    final reloadResult = await getUsersUseCase();
    if (reloadResult.isSuccess) {
      _users = reloadResult.data ?? [];
    } else {
      _errorMessage = reloadResult.error;
    }

    _setLoading(false);
    return reloadResult.isSuccess;
  }

  Future<bool> updateUser({
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
      return false;
    }

    final reloadResult = await getUsersUseCase();
    if (reloadResult.isSuccess) {
      _users = reloadResult.data ?? [];
    } else {
      _errorMessage = reloadResult.error;
    }

    _setLoading(false);
    return reloadResult.isSuccess;
  }

  Future<bool> deleteUser(int id) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await deleteUserUseCase(id);

    if (result.isFailure) {
      _errorMessage = result.error;
      _setLoading(false);
      return false;
    }

    final reloadResult = await getUsersUseCase();
    if (reloadResult.isSuccess) {
      _users = reloadResult.data ?? [];
    } else {
      _errorMessage = reloadResult.error;
    }

    _setLoading(false);
    return reloadResult.isSuccess;
  }

  void _setLoading(bool value) {
    if (_isLoading == value) {
      return;
    }

    _isLoading = value;
    notifyListeners();
  }
}
