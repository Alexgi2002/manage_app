import 'package:flutter/material.dart';
import 'package:manage_app/config/helpers/utils.dart';
import 'package:manage_app/domain/entities/order.dart';

class ItemStatus extends StatelessWidget {
  const ItemStatus({super.key, required this.status, this.disabled = false, this.onTap});

  final Status status;
  final bool disabled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: disabled ? Colors.grey : Utils.getStatusColor(status),
          borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.all(8),
        child: Text(Utils.getStatusText(status), style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.white
        )),
      ),
    );
  }
}