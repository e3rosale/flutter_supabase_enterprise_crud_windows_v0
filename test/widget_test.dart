import 'package:flutter/material.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/presentation/pages/users_page.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/presentation/viewmodels/users_state.dart';
import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/presentation/viewmodels/users_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/users/fakes/fake_user_repository.dart';

void main() {
  testWidgets('UsersPage renders users from the injected view model', (
    tester,
  ) async {
    final repository = FakeUserRepository(
      initialUsers: const [
        UserEntity(id: 1, name: 'Ada Lovelace', email: 'ada@example.com'),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: UsersPage(
          createViewModel: () => UsersViewModel.fromRepository(repository),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text('Ada Lovelace'), findsOneWidget);
    expect(find.text('ada@example.com'), findsOneWidget);
  });

  test('UsersState clears errors when requested', () {
    const state = UsersState(errorMessage: 'Failed');

    final nextState = state.copyWith(clearError: true);

    expect(nextState.errorMessage, isNull);
  });
}
