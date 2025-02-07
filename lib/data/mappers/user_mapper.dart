import 'package:manage_app/domain/entities/user.dart';

class UserMapper {
  static User jsonToOrder(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      password: json['password'],
      rol: Rol.values.firstWhere((e) => e.toString() == json['rol']),
    );
  }
}