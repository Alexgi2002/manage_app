
import 'package:manage_app/data/datasources/usecases/order_api.dart';
import 'package:manage_app/data/datasources/usecases/user_api.dart';
import 'package:manage_app/data/dio/my_dio.dart';
import 'package:manage_app/domain/repositories/remote/remote_repository.dart';
import 'package:manage_app/domain/repositories/remote/usecases/order_repository.dart';
import 'package:manage_app/domain/repositories/remote/usecases/user_repository.dart';

class ApiConsumer extends RemoteRepository {

  static final RemoteRepository _instace = ApiConsumer._();
  late MyDio _myDio;

  late final OrderApi orderApi;
  late final UserApi userApi;

  static RemoteRepository getInstance() => _instace;

  ApiConsumer._() {
    _myDio = MyDio();

    orderApi = OrderApi(_myDio);
    userApi = UserApi(_myDio);
  }

  @override
  OrderRepository get orderRepository => orderApi;

  @override
  UserRepository get userRepository => userApi;

}