import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/fake_user_repository.dart';

void main() {
  test('rejects invalid email before calling the repository', () async {
    final repository = FakeUserRepository();
    final useCase = CreateUser(repository);

    final result = await useCase(name: 'Ada', email: 'invalid');

    expect(result.isFailure, isTrue);
    expect(result.error, 'Enter a valid email address.');
  });

  test('trims valid input before creating the user', () async {
    final repository = FakeUserRepository();
    final useCase = CreateUser(repository);

    final result = await useCase(name: ' Ada ', email: ' ada@example.com ');

    expect(result.isSuccess, isTrue);

    final users = await repository.getUsers();
    expect(users.data!.single.name, 'Ada');
    expect(users.data!.single.email, 'ada@example.com');
  });
}
