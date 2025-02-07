

import 'package:manage_app/domain/repositories/local/usecases/order_repository.dart';
import 'package:manage_app/domain/repositories/local/usecases/user_repository.dart';

abstract class LocalRepository {
  UserRepository get userRepository;
  OrderRepository get orderRepository;

  Future<bool> isEmpty();
}