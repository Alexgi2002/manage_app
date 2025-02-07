

import 'package:isar/isar.dart';
import 'package:manage_app/data/database/usecases/order_db.dart';
import 'package:manage_app/data/database/usecases/user_db.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/domain/repositories/local/local_repository.dart';
import 'package:manage_app/domain/repositories/local/usecases/order_repository.dart';
import 'package:manage_app/domain/repositories/local/usecases/user_repository.dart';
import 'package:path_provider/path_provider.dart';

class Database extends LocalRepository {

  late final UserDb userDb;
  late final OrderDb orderDb;

  static Database? _instance;

  Database._();

  static Database get instance => _instance ??= Database._();


  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [UserSchema, OrderSchema],
      directory: dir.path,
    );

    userDb = UserDb(isar);
    orderDb = OrderDb(isar);
  }

  @override
  OrderRepository get orderRepository => orderDb;

  @override
  UserRepository get userRepository => userDb;
  
  @override
  Future<bool> isEmpty() async {
    return await orderDb.isar.orders.count() == 0;
  }

}