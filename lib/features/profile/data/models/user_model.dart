// lib/features/profile/data/models/user_model.dart
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String email,
    required String name,
  }) : super(id: id, email: email, name: name);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['doc']['_id'] as String,
      email: json['doc']['email'] as String,
      name: json['doc']['name'] as String,
    );
  }
}