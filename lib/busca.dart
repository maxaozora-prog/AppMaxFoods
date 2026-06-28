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
 List sugestoes=[];
 FocusNode focusNode = FocusNode();
 
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
        .contains(texto) ||
        item["category"]
        .toString()
        .toLowerCase()
        .contains(texto); 
  }).toList();

  final resultadoBusca2 = lista.restaurante.where((item) {
    return item["name"]
        .toString()
        .toLowerCase()
        .contains(texto)||
        item["category"]
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
        .contains(texto)||
        item["category"]
        .toString()
        .toLowerCase()
        .contains(texto); 
  }).toList();

  final resultadoBusca2 = lista.restaurante.where((item) {
    return item["name"]
        .toString()
        .toLowerCase()
        .contains(texto)||
        item["category"]
        .toString()
        .toLowerCase()
        .contains(texto); 
  }).toList();

 setState(() {
    menu=resultadoBusca;
    restaurante=resultadoBusca2;
  });
 

}


void atualizarSugestoes(String texto) {
    final busca = texto.toLowerCase();
  
  setState(() {
    final menuFiltrado = lista.menu.where((item) =>
        item["description"].toString().toLowerCase().contains(busca) ||
        item["category"].toString().toLowerCase().contains(busca)
    ).toList();

    final restauranteFiltrado = lista.restaurante.where((item) =>
        item["name"].toString().toLowerCase().contains(busca) ||
        item["category"].toString().toLowerCase().contains(busca)
    ).toList();

    menuFiltrado.shuffle();
    restauranteFiltrado.shuffle(); //Pega valores aleatório

    sugestoes = [      
      ...menuFiltrado.take(1), //Pega o primeiro valor só 1 porque está com valor 1
      ...restauranteFiltrado.take(1),
    ];
  });
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(   //Para fechar a sugestão quando clicar fora.
    onTap: () {
     FocusScope.of(context).unfocus(); // tira o foco do TextField

     setState(() {
      sugestoes.clear(); // fecha sugestões
       });
      }, 
    
    
    
    child:Scaffold(

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
           child:Column(
            children:[
           
          Row(
            children:[
              Expanded(
            child:TextField(
               controller: controller,
               focusNode: focusNode,  //trabalha o foco
               onChanged: atualizarSugestoes, //atualiza a sugestão.
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
           
            FocusScope.of(context).unfocus(); // tira o foco do TextField

            setState(() {
            sugestoes.clear(); // fecha sugestões
            });
          },
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.zero,
           ),
           ),
          child: Text('Buscar'),
          ),
         ]
         ),
         
         //Sugestão mostrado ao digitar
     if (sugestoes.isNotEmpty)
     ListView.builder(
     shrinkWrap: true,
     physics: const NeverScrollableScrollPhysics(),
     itemCount: sugestoes.length,
     itemBuilder: (context, index) {
      return ListTile(
        leading: const Icon(Icons.search),
        title: Text(sugestoes[index]["description"] ?? sugestoes[index]["name"] ?? sugestoes[index]["category"]),
        onTap: () {
          controller.text = sugestoes[index]["description"] ?? sugestoes[index]["name"] ?? sugestoes[index]["category"];
          
          setState(() {
            sugestoes.clear();
          });
        },
      );
    },
  ),
           ]),
         
         ),
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
               fontSize: 14,
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
               fontSize: 14,
            ),
          ),
          subtitle: Text(
            restaurante[index]["distance"],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      );
    },
  ),
),
           ]
      ),
    ));
  }

   @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}