import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_app/config/helpers/dialog_gi.dart';
import 'package:manage_app/config/helpers/utils.dart';
import 'package:manage_app/config/router/router_path.dart';
import 'package:manage_app/config/theme/app_theme.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/presentation/providers/database/database_provider.dart';
import 'package:manage_app/presentation/providers/home/home_provider.dart';
import 'package:manage_app/presentation/widgets/order/item_status.dart';

class TileOrder extends StatelessWidget {
  const TileOrder({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          left: BorderSide(color: colorPrimary, width: 2.5),
        )),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.description,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Fecha de entrega: ${Utils.dateFormat(order.dateDelivery)}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  width: 8,
                ),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final user = ref.watch(homeProvider).me;

                    return ItemStatus(
                      onTap: () async {
                        if(user != null && ((user.rol == Rol.repartidor && order.status == Status.pending) 
                          || (user.rol == Rol.cliente && order.status == Status.processing))){
                            await context.push(RouterPath.SCAN_PAGE,);
                            await ref.read(databaseProvider).orderRepository.updateStatus(order.id, order.status == Status.pending ? Status.processing : Status.completed);
                            ref.read(homeProvider.notifier).getOrders();
                        }
                      },
                      status: order.status,
                    );
                  },
                )
              ],
            ),
            Text('Cantidad de productos: ${order.cantProducts}',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: 8,
            ),
            Text('Cliente: ${order.client?.name}',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Repartidor: ${order.delivery?.name}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  width: 8,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final user = ref.watch(homeProvider).me;

                    return user != null && user.rol == Rol.asignador
                        ? Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.push(RouterPath.ADD_ORDER_PAGE,
                                        extra: order);
                                  },
                                  icon: const Icon(Icons.edit_outlined)),
                              const SizedBox(
                                width: 8,
                              ),
                              IconButton(
                                  onPressed: () {
                                    DialogGI.showAlertDialog(
                                      context,
                                      title: 'Eliminar orden',
                                      content:
                                          '¿Estás seguro que deseas eliminar esta orden?',
                                      actionOk: () async {
                                        context.pop();
                                        await ref
                                            .read(databaseProvider)
                                            .orderRepository
                                            .deleteOrder(order.id);
                                        ref
                                            .read(homeProvider.notifier)
                                            .getOrders();
                                      },
                                    );
                                  },
                                  icon:
                                      const Icon(Icons.delete_outline_rounded)),
                            ],
                          )
                        : SizedBox.shrink();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
