import 'package:flutter/material.dart';
import 'package:manage_app/domain/entities/order.dart';

class Utils {
  static String dateFormat(DateTime date){
    return "${date.day}/${date.month}/${date.year}";
  }

  static Color getStatusColor(Status status){
    switch(status){
      case Status.pending:
        return Colors.blue;
      case Status.processing:
        return Colors.orange;
      case Status.completed:
        return Colors.green;
    }
  }

  static String getStatusText(Status status){
    switch(status){
      case Status.pending:
        return "Pendiente";
      case Status.processing:
        return "Procesando";
      case Status.completed:
        return "Completado";
    }
  }
}