import 'package:app_food/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class Endereco extends StatefulWidget {
  const Endereco({super.key});

  @override
  State<Endereco> createState() => _PasswordresetModalState();
}

class _PasswordresetModalState extends State<Endereco> {
  final _formKey = GlobalKey<FormState>();// para validar
  final _enderecoController = TextEditingController();

  AuthService authService = AuthService();

  @override
  void initState() {
      

    super.initState();
    carregarEndereco();
  }

  Future<void> carregarEndereco() async {    //Para recuperar o valor de endereço
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return;
  }

  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('usuarios')
      .doc(user.uid)
      .get();

  if (doc.exists) {
    Map<String, dynamic> dados =
        doc.data() as Map<String, dynamic>;

    setState(() {
      _enderecoController.text = dados['endereco'] ?? '';
    });
  }
}
  

  Future<void> salvarEndereco() async {          //Salvar endereço.
  String endereco = _enderecoController.text.trim();
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    
    return;
  }

  if (endereco.isEmpty) {
    return;
  }

  await FirebaseFirestore.instance
      .collection('usuarios')
      .doc(user.uid)
      .set({
    'endereco': endereco,
    'atualizadoEm': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}

  @override
  Widget build(BuildContext context) {
          return Dialog(
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Endereço de entrega',style:TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _enderecoController,
            decoration: const InputDecoration(
              labelText: 'Digite seu endereço',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe um endereço';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await salvarEndereco();
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        )
      ],
    ),
  ),
);
}

}