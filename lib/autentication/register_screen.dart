import 'package:app_food/service/auth_service.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  AuthService _authService= AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Max Foods",
          style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900, // 👈 letra bem gorda
          letterSpacing: 1.5,
          color: Colors.orange,
           ),),
      ),
      body: Container(
        color: Colors.orange,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Image.asset("images/icones/delivery-man.png", width: 100,
                   height: 100,
                   fit: BoxFit.cover),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(hintText: 'Nome'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _senhaController,
                      decoration: const InputDecoration(hintText: 'Senha'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _confirmaSenhaController,
                      decoration: const InputDecoration(hintText: 'Confirme sua senha'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_senhaController.text ==
                            _confirmaSenhaController.text) {
                          _authService.cadastrarUsuario(
                            email: _emailController.text,
                            senha: _senhaController.text,
                            nome: _nomeController.text,
                          ).then((String? erro) {
                            if(!context.mounted) return;

                            if (erro != null) {
                              final snackBar = SnackBar(
                                content: Text(erro),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.pop(context);
                            }
                          });
                        } else {
                          const snackBar = SnackBar(
                            content: Text('As senhas não correspondem'),
                            backgroundColor: Colors.red,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text('Cadastrar'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}