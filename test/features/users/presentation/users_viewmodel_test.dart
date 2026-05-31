import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/presentation/viewmodels/users_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/fake_user_repository.dart';

void main() {
  test('loadUsers stores users returned from the repository', () async {
    final repository = FakeUserRepository(
      initialUsers: const [
        UserEntity(id: 1, name: 'Ada', email: 'ada@example.com'),
      ],
    );
    final viewModel = UsersViewModel.fromRepository(repository);

    await viewModel.loadUsers();

    expect(viewModel.state.users.single.name, 'Ada');
    expect(viewModel.state.isLoading, isFalse);
    expect(viewModel.state.errorMessage, isNull);
  });

  test('loadUsers exposes repository failure as an error message', () async {
    final repository = FakeUserRepository(failureMessage: 'Load failed');
    final viewModel = UsersViewModel.fromRepository(repository);

    await viewModel.loadUsers();

    expect(viewModel.state.users, isEmpty);
    expect(viewModel.state.isLoading, isFalse);
    expect(viewModel.state.errorMessage, 'Load failed');
  });
}
