import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] as num).toInt(),
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  Map<String, dynamic> toInsertMap() {
    return {'name': name, 'email': email};
  }

  Map<String, dynamic> toUpdateMap() {
    return {'name': name, 'email': email};
  }
}
