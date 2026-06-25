import 'package:app_food/autentication/register_screen.dart';
import 'package:app_food/autentication/reset_password_modal.dart';
import 'package:app_food/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
   final TextEditingController _senhaController= TextEditingController();
   final TextEditingController _emailController= TextEditingController();
   AuthService authService= AuthService();


  //  Future<UserCredential?> signInWithGoogle() async {
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  // // Inicia o fluxo de login
  // final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  // // Usuário cancelou o login
  // if (googleUser == null) {
  //   return null;
  // }

  // // Obtém autenticação do Google
  // final GoogleSignInAuthentication googleAuth =
  //     await googleUser.authentication;

  // // Cria credencial Firebase
  // final OAuthCredential credential = GoogleAuthProvider.credential(
  //   accessToken: googleAuth.accessToken,
  //   idToken: googleAuth.idToken,
  // );

  // Login no Firebase
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  await googleSignIn.initialize();

  final GoogleSignInAccount? user = await googleSignIn.authenticate();

  if (user == null) return null;

  final GoogleSignInAuthentication auth = await user.authentication;

  final credential = GoogleAuthProvider.credential(
    idToken: auth.idToken,
  );

  return FirebaseAuth.instance.signInWithCredential(credential);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:EdgeInsets.all(16),
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child:Column(
                children: [
                  Image.asset("images/icones/delivery-man.png", width: 100,
               height: 100,
                fit: BoxFit.cover),
                  SizedBox(height:16),
                  TextField(
                    controller:_emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail"
                    )
                  ),
                  SizedBox(height:16),
                  TextField(
                    obscureText: true,
                    controller: _senhaController,
                    decoration:InputDecoration(
                      hintText:"senha"
                    ),
                  ),
                  SizedBox(height:16),
                  ElevatedButton(onPressed:() {
                    authService.entrarUsuario(email: _emailController.text,
                        senha: _senhaController.text).then((String? erro) {
                      if (erro != null) {
                        final snackBar = SnackBar(content: Text(erro),
                            backgroundColor: Colors.red);

                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBar);
                      }
                    });
                  },
                   child: Text("Entrar")),
                  SizedBox(height:16),
                  ElevatedButton(onPressed: (){signInWithGoogle();}, child: Text("Entrar com google")),
                  SizedBox(height:16),
                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));},
                      child: Text("Ainda não tem uma conta? Crie uma conta")
                  ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PasswordresetModal();
                        });
                  },
                  child: Text('Esqueceu sua senha?'),
                )
                ],




              )
            )
          ],
        )
      ),
    );
  }


  

}
