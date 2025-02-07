import 'package:flutter/foundation.dart';
import 'package:manage_app/data/dio/my_dio.dart';
import 'package:manage_app/data/mappers/order_mapper.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/domain/repositories/remote/usecases/order_repository.dart';

class OrderApi extends OrderRepository {
  
  final MyDio dio;

  OrderApi(this.dio);

  final String path = '/order';
  
  @override
  Future<List<Order>> getOrders() async {
    try {
      final result = await dio.request(requestType: RequestType.GET, path: path);
        
      final list = result['data'] as List;
      
      return list.map((e) => OrderMapper.jsonToOrder(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception('Error al obtener las órdenes');
    }
  }
  
}