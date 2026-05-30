import 'package:flutter_supabase_enterprise_crud_windows_v0/features/users/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String email;

  const UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: (map['id'] as num).toInt(),
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email);
  }

  Map<String, dynamic> toInsertMap() {
    return {'name': name, 'email': email};
  }

  Map<String, dynamic> toUpdateMap() {
    return {'name': name, 'email': email};
  }
}
