import 'package:manage_app/domain/entities/order.dart';

abstract class OrderRepository{
  Future<void> saveOrder(Order order);
  Future<void> saveOrders(List<Order> orders);
  Future<Order?> getOrder(int id);
  Future<List<Order>> getOrders(int userId);
  Future<void> deleteOrder(int id);
  Future<void> updateStatus(int id, Status status);
}