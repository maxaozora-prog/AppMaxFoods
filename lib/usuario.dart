import 'package:app_food/address.dart';
import 'package:app_food/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';




class Usuario extends StatelessWidget {
  final User user;
  const Usuario({super.key, required this.user});//Passando um parametro nomeado.

   dynamic card(String text, Icon icone, Color color, [VoidCallback? onTap]){
  return Card(
            color: color,
            elevation: 4,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
             ),
             child: InkWell(
             borderRadius: BorderRadius.circular(12),
             onTap: onTap,
              child: Padding(
             padding: const EdgeInsets.all(16),
             child: Row(
             children: [
              icone,
             SizedBox(width: 16),
             Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ],
          ),
        ],
      ),
    ),
  ),
);
 }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
            color: Colors.orangeAccent, // 👈 cor do fundo
             ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.manage_accounts_rounded,
                size: 48,
              ),
            ),
            accountName: Text(
              (user.displayName != null) ? user.displayName! : '',  style: TextStyle(
              color: Colors.black,
               ),

            ),
            accountEmail: Text(user.email! , style:TextStyle(color:Colors.black)),
          ),
          card("endereço",Icon(Icons.location_on, size: 40, ), Colors.white,() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Endereco();
                        });
                  },),
          card("Pedidos finalizados",Icon(Icons.done, size: 40), Colors.white),
          card("Pedidos em andamento",Icon(Icons.delivery_dining, size: 40), Colors.white),
          card("Ajuda",Icon(Icons.help, size: 40), Colors.white),
          SizedBox(height: 100),
          card("Sair",Icon(Icons.delivery_dining, size: 40),Colors.orangeAccent,(){AuthService().deslogar(); }),

        
        ],
      );
    
  }
}