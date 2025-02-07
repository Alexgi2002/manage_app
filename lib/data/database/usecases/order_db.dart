import 'package:isar/isar.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/domain/repositories/local/usecases/order_repository.dart';

class OrderDb extends OrderRepository {

  final Isar isar;

  OrderDb(this.isar);

  @override
  Future<void> deleteOrder(int id) async {
    isar.writeTxn(() async {
      await isar.orders.delete(id);
    });
  }

  @override
  Future<Order?> getOrder(int id) {
    return isar.orders.filter().idEqualTo(id).findFirst();
  }

  @override
  Future<List<Order>> getOrders(int userId) async {
    final user = await isar.users.get(userId);
    if(user!=null && user.rol == Rol.asignador){
      return isar.orders.where().findAll();
    }
    
    return isar.orders.filter().idClientEqualTo(userId).or().idDeliveryEqualTo(userId).findAll();
  }

  @override
  Future<void> saveOrder(Order order) async {
    isar.writeTxn(() async {
      await isar.orders.put(order); 
    });
  }

  @override
  Future<void> updateStatus(int id, Status status) async {
    final order = await getOrder(id);
    if(order != null){
      order.status = status;

      await saveOrder(order);
    }
  }
  
  @override
  Future<void> saveOrders(List<Order> orders) {
    return isar.writeTxn(() async {
      for(final order in orders){
        await isar.orders.put(order);
      }
    });
  }

}