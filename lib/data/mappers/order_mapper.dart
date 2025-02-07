import 'package:manage_app/domain/entities/order.dart';

class OrderMapper {
  static Order jsonToOrder(Map<String, dynamic> json) {
    return Order(
      idClient: json['idClient'],
      description: json['description'],
      idDelivery: json['idDelivery'],
      cantProducts: json['cantProducts'],
      dateDelivery: DateTime.now(),
      status: Status.values.firstWhere(
        (element) => element.name == (json['status'] as String).toLowerCase(),
        orElse: () => Status.pending,
      ),
    );
  }
}