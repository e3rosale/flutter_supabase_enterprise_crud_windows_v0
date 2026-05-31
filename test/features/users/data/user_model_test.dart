import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromMap converts Supabase rows into a user model', () {
    final model = UserModel.fromMap({
      'id': 7,
      'name': 'Grace Hopper',
      'email': 'grace@example.com',
    });

    expect(model.id, 7);
    expect(model.name, 'Grace Hopper');
    expect(model.email, 'grace@example.com');
  });
}
