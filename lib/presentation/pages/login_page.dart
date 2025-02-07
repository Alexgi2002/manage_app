import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_app/config/helpers/snackbar_gi.dart';
import 'package:manage_app/config/router/router_path.dart';
import 'package:manage_app/data/database/database.dart';
import 'package:manage_app/presentation/widgets/shared/input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final user = TextEditingController();
  final password = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Iniciar sesión", style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 32,),
            InputText(
              textController: user, 
              label: "Usuario",
              prefixIcon: const Icon(Icons.person_outline),
              keyboardType: TextInputType.name
            ),
            const SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }, 
                    icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: FilledButton(
          onPressed: () async {
            if(user.text.trim().isEmpty){
              SnackbarGI.show(context, text: 'Revise el nombre de usuario');
            }
            else if(password.text.trim().isEmpty){
              SnackbarGI.show(context, text: 'Revise su contraseña');
            }
            
            final result = await Database.instance.userRepository.login(user.text.trim().toLowerCase(), password.text.trim());
            
            if(result){
              context.go(RouterPath.HOME_PAGE);
            }
            else{
              SnackbarGI.show(context, text: 'Usuario o contraseña incorrectos');
            }
          }, 
          child: const Text("INICIAR")
        ),
      ),
    );
  }
}