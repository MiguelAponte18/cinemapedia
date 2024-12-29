import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  FullScreenLoader({super.key});


final message = <String>[
  'Cargando peliculas',
  'Comprando palomitas de maiz',
  'Cargando populares',
  'Llamando a mi novia',
  'Ya casi...',
  'Esto esta tardando mas de lo esperado :C'

];

Stream <String> getLoadingMessage(){
  return Stream.periodic(const Duration(milliseconds:1200),(index){//va a estar retornando cada cierto tiempo
    return message[index];
  }).take(message.length);//con el take cancelamos el periodic
}
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10,),
         StreamBuilder(
          stream: getLoadingMessage(),
          builder:(context, snapshot) {

            if(!snapshot.hasData) return const Text('Cargando...');
            return Text(snapshot.data!);//forzamos porque sabemos que va a tener data
          },
          )

        ],
      ),
    );
  }
}