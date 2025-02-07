import 'package:manage_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> saveUser(User user);
  Future<void> saveUsers(List<User> users);
  Future<User?> getUser(int id);
  Future<List<User>> getUsers(Rol rol);
  Future<void> deleteUser(int id);
  Future<bool> login(String name, String password);
  Future<bool> changePassword(int id, String password, String newPassword);
}