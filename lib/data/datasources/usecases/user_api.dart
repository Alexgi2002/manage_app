import 'package:manage_app/data/dio/my_dio.dart';
import 'package:manage_app/data/mappers/user_mapper.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/domain/repositories/remote/usecases/user_repository.dart';

class UserApi extends UserRepository {

  final MyDio dio;

  UserApi(this.dio);

  final String path = '/user';
  
  @override
  Future<List<User>> getUsers() async {
    final result = await dio.request(requestType: RequestType.GET, path: path);
  
    final list = result['data'] as List;
    
    return list.map((e) => UserMapper.jsonToOrder(e)).toList();
  }
}