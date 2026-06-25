

import 'package:app_food/autentication/login_screen.dart';
import 'package:app_food/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoteadorTelas extends StatelessWidget {
  const RoteadorTelas({super.key});

  @override   // Usa os atributos importantos do import 'package:firebase_auth/firebase_auth.dart';
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.userChanges(), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if(snapshot.hasData) {
          // return HomeScreen(user: snapshot.data!);//parametro nomeado
          return Usuario(user: snapshot.data!);
        } else {
          return LoginScreen();
        }
      }
    });
  }
}