// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'user.g.dart';

enum Rol{
  asignador,
  repartidor,
  cliente
}

@collection
class User {
  Id id = Isar.autoIncrement;

  String name;

  String password;

  @Enumerated(EnumType.name)
  Rol rol;

  User({
    required this.name,
    required this.password,
    required this.rol,
  });
}
