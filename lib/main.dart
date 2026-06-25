import 'dart:ui';
import 'package:app_food/rotear_telas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:app_food/deliciousScreen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lanches App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Maxfoods(),
    );
  }
}
class Maxfoods extends StatelessWidget {
   

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: const TabBarView(
            children: [
              DeliciousScreen(),
              RoteadorTelas(),
              
            ],
          ),
          bottomNavigationBar: const Material(
            color: Colors.white,
            child: SizedBox(
             height: 60,
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.restaurant, color:Colors.orange, size: 36)),
                Tab(icon: Icon(Icons.person, color:Colors.orange, size: 36)),
              
              ],
            ),
            )
          ),
        ),
      ),
    );
  }
}