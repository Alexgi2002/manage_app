// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:manage_app/data/storage.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/presentation/providers/api_provider.dart';
import 'package:manage_app/presentation/providers/database/database_provider.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  
  final Ref ref;
  
  HomeNotifier(this.ref): super(HomeState(orders: [], error: false)){
    getOrders();
    getMeUser();
  }

  Future<void> getOrders() async { 
    try {
      final database = ref.read(databaseProvider);
      
      final isEmpty = await database.isEmpty();
      
      if(isEmpty){
        final api = ref.read(apiProvider);
        
        final results = await api.orderRepository.getOrders();
        
        await database.orderRepository.saveOrders(results);
      
        for(final r in results){
          Storage.instance.setStock(Storage.instance.getStock() + r.cantProducts);
        }
        Storage.instance.setStock(Storage.instance.getStock() + 20);
      }
      
      final orders = await database.orderRepository.getOrders(Storage.instance.getId());
      for(final order in orders){
        order.client = await database.userRepository.getUser(order.idClient);
        order.delivery = await database.userRepository.getUser(order.idDelivery);
      }
      
      state = state.copyWith(orders: orders.reversed.toList());

    } catch (e) {
      state = state.copyWith(error: true);
    }
  }
  
  void getMeUser() async {
    final user = await ref.read(databaseProvider).userRepository.getUser(Storage.instance.getId());

    state = state.copyWith(me: user);
  }
    
}

class HomeState {
  User? me;
  List<Order> orders;
  bool error;

  HomeState({
    this.me,
    required this.orders,
    required this.error,
  });


  HomeState copyWith({
    User? me,
    List<Order>? orders,
    bool? error,
  }) {
    return HomeState(
      me: me ?? this.me,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }
}
