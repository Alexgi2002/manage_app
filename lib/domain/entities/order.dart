import 'package:isar/isar.dart';
import 'package:manage_app/domain/entities/user.dart';

part 'order.g.dart';

enum Status{
  pending,
  processing,
  completed,
}


@collection
class Order {
  Id id = Isar.autoIncrement;

  int idClient;

  String description;

  int idDelivery;

  int cantProducts;

  DateTime dateDelivery;

  @Enumerated(EnumType.name)
  Status status;

  @ignore
  User? client;

  @ignore
  User? delivery;

  Order({
    required this.idClient,
    required this.description,
    required this.idDelivery,
    required this.cantProducts,
    required this.dateDelivery,
    required this.status,
  });

}