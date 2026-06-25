import 'package:app_food/service/auth_service.dart';
import 'package:flutter/material.dart';




class PasswordresetModal extends StatefulWidget {
  const PasswordresetModal({super.key});

  @override
  State<PasswordresetModal> createState() => _PasswordresetModalState();
}

class _PasswordresetModalState extends State<PasswordresetModal> {
  final _formKey = GlobalKey<FormState>();// para validar
  final _emailController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Recuperar senha'),
      content: Form(
        key: _formKey,// para validar
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Endereço de e-mail'),
          validator: (value) {
            if(value!.isEmpty) {
              return 'Informe um endereço de e-mail válido';
            }
            return null;
          },
        ),

      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(//Para recuperar senha. A escrita do e-mail enviado é formulado pelo firebase.
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              authService
                  .redefinicaoSenha(email: _emailController.text)
                  .then((String? erro) {
                Navigator.of(context).pop();

                if (erro != null) {
                  final snackBar = SnackBar(
                      content: Text(erro), backgroundColor: Colors.red);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                        'Um link de redefinição de senha foi enviado para o seu e-mail: ${_emailController.text}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            }
          },
          child: Text('Recuperar senha'),
        )
      ],
    );
  }
}