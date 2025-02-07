import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_app/config/router/router_path.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/presentation/providers/home/home_provider.dart';
import 'package:manage_app/presentation/widgets/order/item_status.dart';
import 'package:manage_app/presentation/widgets/order/tile_order.dart';
import 'package:flutter/material.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final searching = useState(false);
    final ValueNotifier<Status?> statusFilter = useState(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage App"),
        actions: [
          IconButton(
            onPressed: () {
              searching.value = !searching.value;
              if(!searching.value){
                statusFilter.value = null;
              }
            },
            icon: Icon(!searching.value ? Icons.filter_alt_outlined : Icons.filter_alt_off_outlined), 
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              context.push(RouterPath.SETTINGS_PAGE);
            }, 
            icon: const Icon(Icons.settings_outlined)
          ),
          const SizedBox(width: 12),
        ],
        bottom: searching.value ? AppBar(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ItemStatus(
                  onTap: () {
                    if(statusFilter.value == Status.pending){
                      statusFilter.value = null;
                    }
                    else{
                      statusFilter.value = Status.pending;
                    }
                  },
                  disabled: statusFilter.value != null && statusFilter.value != Status.pending,
                  status: Status.pending
                ),
                const SizedBox(width: 8,),
                ItemStatus(
                  onTap: () {
                    if(statusFilter.value == Status.processing){
                      statusFilter.value = null;
                    }
                    else{
                      statusFilter.value = Status.processing;
                    }
                  },
                  disabled: statusFilter.value!=null && statusFilter.value != Status.processing,
                  status: Status.processing
                ),
                const SizedBox(width: 8,),
                ItemStatus(
                  onTap: () {
                    if(statusFilter.value == Status.completed){
                      statusFilter.value = null;
                    }
                    else{
                      statusFilter.value = Status.completed;
                    }
                  },
                  disabled: statusFilter.value!=null && statusFilter.value != Status.completed,
                  status: Status.completed
                ),
                const SizedBox(width: 8,),
              ]
            ),
          ),
        ) : null,
      ),
      body: Consumer(
        builder: (context, ref, child) {

          final state = ref.watch(homeProvider);

          if(state.error){
            return const Center(child: Text("Error al cargar las órdenes"));
          }

          if(state.orders.isNotEmpty){

            final list = [];
            if(statusFilter.value != null){
              list.addAll(state.orders.where((e) => e.status == statusFilter.value).toList());
            }
            else {
              list.addAll(state.orders);
            }

            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return TileOrder(order: list[index]);
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {

          final user = ref.watch(homeProvider).me;

          if(user != null && user.rol == Rol.asignador){
            return FloatingActionButton(
              onPressed: () {
                context.push(RouterPath.ADD_ORDER_PAGE);
              }, 
              child: const Icon(Icons.add_rounded)
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  
}