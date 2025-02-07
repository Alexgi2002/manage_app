// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_app/domain/entities/order.dart';

import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/presentation/providers/database/database_provider.dart';
import 'package:manage_app/presentation/providers/home/home_provider.dart';

final addOrderProvider = StateNotifierProvider<AddOrderNotifier, AddOrderState>((ref) {
  return AddOrderNotifier(ref);
});

class AddOrderNotifier extends StateNotifier<AddOrderState> {
  
  final Ref ref;
  
  AddOrderNotifier(this.ref): super(AddOrderState(clients: [], deliveries: [])){
    getUsers();
  }

  Future<void> getUsers() async {
    final clients = await ref.read(databaseProvider).userRepository.getUsers(Rol.cliente);
    final deliveries = await ref.read(databaseProvider).userRepository.getUsers(Rol.repartidor);
  
    state = state.copyWith(clients: clients, deliveries: deliveries);
  }

  Future<bool> addOrder(String description, String cantProducts, int cliente, int repartidor, DateTime date, Status status, Order? order) async{ 
    final database = ref.read(databaseProvider);

    
    if(repartidor==-1){
      final users = await database.userRepository.getUsers(Rol.repartidor);
      if(users.isNotEmpty){
        repartidor = users[Random().nextInt(users.length)].id;
      }
    }

    Order? data = order;

    if(data != null){
      data.idClient = cliente;
      data.description = description;
      data.idDelivery = repartidor;
      data.cantProducts = int.parse(cantProducts);
      data.dateDelivery = date;
      data.status = status;
    }
    else{
      data= Order(
        idClient: cliente,
        description: description,
        idDelivery: repartidor,
        cantProducts: int.parse(cantProducts),
        dateDelivery: date,
        status: status,
      );
    }

    await ref.read(databaseProvider).orderRepository.saveOrder(data);

    ref.read(homeProvider.notifier).getOrders();

    return true;
  }
    
}

class AddOrderState {
  List<User> clients;
  List<User> deliveries;
  
  AddOrderState({
    required this.clients,
    required this.deliveries,
  });

  AddOrderState copyWith({
    List<User>? clients,
    List<User>? deliveries,
  }) {
    return AddOrderState(
      clients: clients ?? this.clients,
      deliveries: deliveries ?? this.deliveries,
    );
  }
}
