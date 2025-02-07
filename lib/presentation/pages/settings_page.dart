import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_app/config/helpers/dialog_gi.dart';
import 'package:manage_app/config/router/router_path.dart';
import 'package:manage_app/data/storage.dart';
import 'package:manage_app/presentation/widgets/shared/theme_change.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const ThemeChangeWidget(),
              const SizedBox(height: 8,),
              ListTile(
                onTap: () {
                  context.push(RouterPath.CHANGE_PASSWORD_PAGE);
                },
                leading: const Icon(Icons.lock_outline),
                title: const Text("Cambiar contraseña"),
              ),
              const SizedBox(height: 8,),
              ListTile(
                onTap: () {
                  DialogGI.showAlertDialog(
                    context, 
                    title: 'Cerrar sesión',
                    content: '¿Estás seguro que deseas cerrar sesión?',
                    actionOk: () {
                      context.pop();
                      Storage.instance.setId(-1);
                      context.go(RouterPath.LOGIN_PAGE);
                    },
                  );
                  
                },
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Cerrar sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}