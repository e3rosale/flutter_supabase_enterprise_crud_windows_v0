import 'package:flutter_supabase_enterprise_crud_windows_v0/core/utils/result.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/core/validation/email_validator.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/repositories/user_repository.dart';

class CreateUser {
  final UserRepository repository;

  CreateUser(this.repository);

  Future<Result<void>> call({required String name, required String email}) {
    final validationError = _validate(name: name, email: email);
    if (validationError != null) {
      return Future.value(Result.failure(validationError));
    }

    return repository.createUser(name: name.trim(), email: email.trim());
  }

  String? _validate({required String name, required String email}) {
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
