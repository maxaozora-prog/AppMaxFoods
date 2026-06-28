import 'package:app_food/Lista.dart';
import 'package:app_food/busca.dart';
import 'package:flutter/material.dart';

class DeliciousScreen extends StatefulWidget {
   const DeliciousScreen({super.key});

  @override
  State<DeliciousScreen> createState() => _DeliciousScreenState();
}

class _DeliciousScreenState extends State<DeliciousScreen> {

  TextEditingController controller=TextEditingController();
  Lista lista= Lista();
  List sugestoes = [];
  FocusNode focusNode = FocusNode();

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
           child:Column(children:[   //Collumn criado para agregar o if
          Row(
            children:[
              
              Expanded(
            child:TextField(
              focusNode: focusNode,  //trabalha o foco
              controller: controller,
              onChanged: atualizarSugestoes, //atualiza a sugestão
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Busca(dado: controller.text)));
          
            setState(() {
            sugestoes.clear(); // fecha sugestões
            
            });

             FocusScope.of(context).unfocus(); // tira o foco do TextField
             FocusManager.instance.primaryFocus?.unfocus(); // Faz a mesma coisa caso o de cima não resolva

          
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
         
         //Lista de sugestões ao digitar.
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
         Padding(
           padding: const EdgeInsets.all(16.0),
         
          child:Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
            
            Column(children:[
              Image.asset(
               'images/icones/1.png',
               width: 35,
               height: 35,
               fit: BoxFit.cover,
               
                ),
                Text("Salgados")
          ]),
           Column(children:[
              Image.asset(
               'images/icones/2.png',
               width: 35,
               height: 35,
                fit: BoxFit.cover,
               
                ),
                Text("Lanches")
          ]),
           Column(children:[
              Image.asset(
               'images/icones/3.png',
               width: 35,
               height: 35,
                fit: BoxFit.cover,
              
                ),
                Text("Sobremesas")
          ]),
           Column(children:[
              Image.asset(
               'images/icones/4.png',
               width: 35,
               height: 35,
                fit: BoxFit.cover,
              
                ),
                Text("Japonesa")
          ]),
          
          ]),
          
         ),
         SizedBox(height: 10),
          Padding(
           padding: const EdgeInsets.all(16.0),
         
          
          child: SizedBox(
                height: 160,
                child:ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          
                          itemCount: lista.products.length,
                          itemBuilder: (context, index) {
                            return  Container(
                              height:160,
                                width: 200,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child:
                                  Image.asset(lista.products[index]["image"],width:200,height:150,
                                   fit: BoxFit.cover,
                                   ),
                                
                              );
                            
                          }
                        ),
               
            
          ),
        ),
          
          Padding(
           padding: const EdgeInsets.all(16.0),
           child:Row(children:[
            Image.asset('images/icones/6.png',
            width: 40,
            height: 40,
             fit: BoxFit.cover,
               ),
            Text(' Pratos Deliciosos :',
             style: TextStyle(
             fontWeight: FontWeight.bold,
            ),)

          ])
          ),

           Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
         
          
          child: SizedBox(
                height: 210,
                child:ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          
                          itemCount: lista.menu.length,
                          itemBuilder: (context, index) {
                            return  Container(
                              height:210,
                                width: 200,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child:
                                Column( children:[

                                  Image.asset(lista.menu[index]["image"],width:200,height:150,
                                   fit: BoxFit.cover,
                                   ),
                                  // SizedBox(height:5),
                                  Text("RS ${lista.menu[index]["price"]}",
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                   ),),
                                  Text("${lista.menu[index]["description"]}"),




                                ])
                                  
                                
                              );
                            
                          }
                        ),
               
            
          ),
        ),
          
           Padding(
           padding: const EdgeInsets.all(16.0),
           child:Row(children:[
            Image.asset('images/icones/5.png',
            width: 40,
            height: 40,
             fit: BoxFit.cover,
               ),
            Text(' Restaurantes Proximo :',
             style: TextStyle(
             fontWeight: FontWeight.bold,
            ),)

          ])
          ),

          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: lista.restaurante.length,
           itemBuilder: (context, index) {
          return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
           leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              lista.restaurante[index]["Image"],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              
            ),
          ),
          title: Text(
            lista.restaurante[index]["name"],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
               fontSize: 14,
            ),
          ),
          subtitle: Text(
            lista.restaurante[index]["distance"],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      );
    },
  ),
),


      ] 
      )
      ) 
      );
  }

  @override
  void dispose() {
  controller.dispose();
  focusNode.dispose(); 
  super.dispose();
}
}