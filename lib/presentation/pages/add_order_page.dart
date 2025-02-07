import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manage_app/config/helpers/snackbar_gi.dart';
import 'package:manage_app/config/helpers/utils.dart';
import 'package:manage_app/domain/entities/order.dart';
import 'package:manage_app/presentation/providers/add_order_provider.dart';
import 'package:manage_app/presentation/widgets/shared/input_text.dart';

class AddOrderPage extends StatefulHookWidget {
  const AddOrderPage({super.key, this.order});

  final Order? order;

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {

  final description = TextEditingController();

  final cantProducts = TextEditingController();

  int cliente = -1;

  int repartidor = -1;

  @override
  void initState() {
    super.initState();

    if(widget.order != null){
      description.text = widget.order!.description;
      cantProducts.text = widget.order!.cantProducts.toString();
      cliente = widget.order!.client?.id ?? -1;
      repartidor = widget.order!.delivery?.id ?? -1;
    }
  }

  @override
  Widget build(BuildContext context) {


    final date = useState(widget.order != null ? widget.order!.dateDelivery : DateTime.now());
    final status = useState(widget.order != null ? widget.order!.status : Status.pending);


    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar orden"),
      ),
      body: Consumer(
        builder: (context, ref, child) {

          final state = ref.watch(addOrderProvider);

          if(state.clients.isEmpty){
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    value: cliente == -1 ? null : cliente,
                    onChanged: (value) {
                      cliente = value ?? -1;
                    },
                    borderRadius: BorderRadius.circular(12),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Selecciona un cliente"),
                    items: state.clients.map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    )).toList()
                  ),
                ),
                const SizedBox(height: 8,),
                InputText(
                  textController: description, 
                  label: 'Descripción',
                  keyboardType: TextInputType.text
                ),
                const SizedBox(height: 8,),
                ListTile(
                  onTap: () async {
                    final result = await showDatePicker(
                      context: context, 
                      firstDate: DateTime.now(), 
                      lastDate: DateTime(2026)
                    );

                    if(result != null){
                      date.value = result;
                    }
                  },
                  leading: const Icon(Icons.calendar_month_outlined),
                  title: const Text("Fecha de entrega"),
                  subtitle: Text(Utils.dateFormat(date.value)),
                ),
                const SizedBox(height: 8,),
                Text('   Estado', style: Theme.of(context).textTheme.titleMedium),
                RadioListTile<Status>(
                  value: Status.pending, 
                  groupValue: status.value, 
                  onChanged: (value) {
                    status.value = value!;
                  },
                  title: const Text("Pendiente"),
                ),
                RadioListTile<Status>(
                  value: Status.processing, 
                  groupValue: status.value, 
                  onChanged: (value) {
                    status.value = value!;
                  },
                  title: const Text("Procesando"),
                ),
                RadioListTile<Status>(
                  value: Status.completed, 
                  groupValue: status.value, 
                  onChanged: (value) {
                    status.value = value!;
                  },
                  title: const Text("Completado"),
                ),
                const SizedBox(height: 8,),
                InputText(
                  textController: cantProducts, 
                  label: 'Cantidad de productos',
                  keyboardType: TextInputType.number
                ),
                const SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    value: repartidor == -1 ? null : repartidor,
                    onChanged: (value) {
                      repartidor = value ?? -1;
                    },
                    borderRadius: BorderRadius.circular(12),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Selecciona un repartidor"),
                    items: state.deliveries.map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    )).toList()
                  ),
                ),
                const SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FilledButton(
                    onPressed: () async {
                      if(description.text.trim().isEmpty){
                        SnackbarGI.show(context, text: 'Revise la descripción');
                      }
                      else if(cantProducts.text.trim().isEmpty || int.tryParse(cantProducts.text.trim())==null){
                        SnackbarGI.show(context, text: 'Revise la cantidad de productos');
                      }
                      else if(cliente == -1){
                        SnackbarGI.show(context, text: 'Seleccione un cliente');
                      }
                      else{
                        final result = await ref.read(addOrderProvider.notifier).addOrder(description.text, cantProducts.text, cliente, repartidor, date.value, status.value, widget.order);
                        if(result){
                          SnackbarGI.show(context, text: widget.order == null ? 'Orden agregada exitosamente' : 'Orden actualizada exitosamente');
                          context.pop();
                        }
                        else{
                          SnackbarGI.show(context, text: 'No hay suficiente Stock');
                        }
                      }
                    }, 
                    child: Center(child: Text(widget.order == null ? "Agregar" : "Actualizar"))
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}