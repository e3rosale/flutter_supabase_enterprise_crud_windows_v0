import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/core/validation/email_validator.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<Result<void>> call({
    required int id,
    required String name,
    required String email,
  }) {
    final validationError = _validate(id: id, name: name, email: email);
    if (validationError != null) {
      return Future.value(Result.failure(validationError));
    }

    return repository.updateUser(
      id: id,
      name: name.trim(),
      email: email.trim(),
    );
  }

  String? _validate({
    required int id,
    required String name,
    required String email,
  }) {
    if (id <= 0) {
      return 'User id must be valid.';
    }
    if (name.trim().isEmpty) {
      return 'Name is required.';
    }
    if (name.trim().length > 120) {
      return 'Name must be 120 characters or fewer.';
    }
    if (!EmailValidator.isValid(email)) {
      return 'Enter a valid email address.';
    }
    if (email.trim().length > 320) {
      return 'Email must be 320 characters or fewer.';
    }
    return null;
  }
}
