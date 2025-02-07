

import 'package:manage_app/domain/repositories/remote/usecases/user_repository.dart';
import 'package:manage_app/domain/repositories/remote/usecases/order_repository.dart';

abstract class RemoteRepository {
  OrderRepository get orderRepository;
  UserRepository get userRepository;
}