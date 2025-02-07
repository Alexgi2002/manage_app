import 'package:manage_app/domain/entities/user.dart';

abstract class UserRepository{
  Future<List<User>> getUsers();
}