import 'package:app_food/Lista.dart';
import 'package:flutter/material.dart';

class Busca extends StatefulWidget {
  String dado;
  Busca({super.key, required this.dado});

  @override
  State<Busca> createState() => _BuscaState();
}

class _BuscaState extends State<Busca> {
 TextEditingController controller=TextEditingController();
 Lista lista = Lista();
 List menu=[];
 List restaurante=[];
 
 
 @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.dado,
    );
    lista1();
  }

  void buscar() {
  String texto = controller.text.trim().toLowerCase();
  menu.clear();
  restaurante.clear();

  final resultadoBusca = lista.menu.where((item) {
    return item["description"]
        .toString()
        .toLowerCase()
        .contains(texto);
  }).toList();

  final resultadoBusca2 = lista.restaurante.where((item) {
    return item["name"]
        .toString()
        .toLowerCase()
        .contains(texto);
  }).toList();

  setState(() {
    menu=resultadoBusca;
    restaurante=resultadoBusca2;
  });
}


dynamic lista1 (){
  String texto = controller.text.trim().toLowerCase();
final resultadoBusca = lista.menu.where((item) {
    return item["description"]
        .toString()
        .toLowerCase()
        .contains(texto);
  }).toList();

  final resultadoBusca2 = lista.restaurante.where((item) {
    return item["name"]
        .toString()
        .toLowerCase()
        .contains(texto);
  }).toList();

 setState(() {
    menu=resultadoBusca;
    restaurante=resultadoBusca2;
  });
 

}


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
           ),
        ),
      ),
      body: ListView(
           children: [
          Padding(
           padding: const EdgeInsets.all(16.0),
          child:Row(
            children:[
              Expanded(
            child:TextField(
               controller: controller,
         decoration: InputDecoration(
         labelText: 'Digite a sua busca',
         border: OutlineInputBorder(),
         prefixIcon: Icon(Icons.search),
         ),
         ),),
         SizedBox(width: 10),

          ElevatedButton(
          onPressed: () {
           if (controller.text.isNotEmpty)
           buscar();
           
          },
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.zero,
           ),
           ),
          child: Text('Buscar'),
          ),
         ]
         ),),
         SizedBox(height:10),
         if (menu.isEmpty && restaurante.isEmpty)
         Center(child:Text("Item não encontrado",
         style: TextStyle(
         fontSize: 25,
         fontWeight: FontWeight.w900, // 👈 letra bem gorda
         letterSpacing: 1.5,
         color: Colors.orange,
           ),)),

          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menu.length,
           itemBuilder: (context, index) {
          return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
           leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              menu[index]["image"],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              
            ),
          ),
          title: Text(
            menu[index]["description"],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("RS ${menu[index]["price"]}",
          ),
          
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      );
    },
  ),
),

 Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurante.length,
           itemBuilder: (context, index) {
          return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
           leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              restaurante[index]["Image"],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              
            ),
          ),
          title: Text(
            restaurante[index]["name"],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            restaurante[index]["description"],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      );
    },
  ),
),
           ]
      ),
    );
  }

   @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}