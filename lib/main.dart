import 'package:manage_app/config/router/router.dart';
import 'package:manage_app/config/theme/app_theme.dart';
import 'package:manage_app/data/database/database.dart';
import 'package:manage_app/data/storage.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage.instance.init();

  await Database.instance.init();

  final database = Database.instance;
  if(await database.isEmpty()){
    await database.userRepository.saveUsers([
      User(name: "asignador", password: "123456", rol: Rol.asignador),
      User(name: "repartidor1", password: "123456", rol: Rol.repartidor),
      User(name: "cliente1", password: "123456", rol: Rol.cliente),
      User(name: "cliente2", password: "123456", rol: Rol.cliente),
      User(name: "repartidor2", password: "123456", rol: Rol.repartidor),
    ]);
  } 

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {

        final isDarkTheme = ref.watch(isDarkThemeProvider);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Manage App',
          theme: AppTheme(isDark: isDarkTheme).theme(),
          darkTheme: AppTheme().themeDark(),
          themeMode: ThemeMode.system,
          routerConfig: appRouter,
        );
      },
    );
  }
}
