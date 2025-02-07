import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_app/config/helpers/snackbar_gi.dart';
import 'package:manage_app/data/storage.dart';
import 'package:manage_app/presentation/providers/database/database_provider.dart';

class ChangePasswordPage extends HookWidget {
  ChangePasswordPage({super.key});

  final password = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final showPassword1 = useState(false);
    final showPassword2 = useState(false);
    final showPassword3 = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cambiar contraseña"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: password,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: !showPassword1.value,
                decoration: InputDecoration(
                  labelText: "Contraseña actual",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPassword1.value = !showPassword1.value;
                    }, 
                    icon: Icon(showPassword1.value ? Icons.visibility_off : Icons.visibility)
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: newPassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: !showPassword2.value,
                decoration: InputDecoration(
                  labelText: "Nueva contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPassword2.value = !showPassword2.value;
                    }, 
                    icon: Icon(showPassword2.value ? Icons.visibility_off : Icons.visibility)
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: confirmPassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: !showPassword3.value,
                decoration: InputDecoration(
                  labelText: "Confirmar contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPassword3.value = !showPassword3.value;
                    }, 
                    icon: Icon(showPassword3.value ? Icons.visibility_off : Icons.visibility)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (_, WidgetRef ref, __) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: FilledButton(
                onPressed: () async {
                  if(password.text.trim().isEmpty){
                    SnackbarGI.show(context, text: 'Revise la contraseña actual');
                  }
                  else if(newPassword.text.trim().isEmpty){
                    SnackbarGI.show(context, text: 'Revise la nueva contraseña');
                  }
                  else if(confirmPassword.text.trim().isEmpty){
                    SnackbarGI.show(context, text: 'Revise la confirmación de la contraseña');
                  }
                  else if(newPassword.text.trim() != confirmPassword.text.trim()){
                    SnackbarGI.show(context, text: 'Las contraseñas no coinciden');
                  }
                  else{
                    final result = await ref.read(databaseProvider).userRepository.changePassword(Storage.instance.getId(), password.text.trim(), newPassword.text.trim());
                  
                    if(result){
                      SnackbarGI.show(context, text: 'Contraseña cambiada exitosamente');
                      context.pop();
                    }
                    else{
                      SnackbarGI.show(context, text: 'Revise la contraseña actual');
                    }
                  }
                }, 
                child: Text('ACEPTAR')
              ),
          );
        },
      ),
    );
  }
}