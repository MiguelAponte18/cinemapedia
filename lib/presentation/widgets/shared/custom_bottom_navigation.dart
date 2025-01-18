import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key, required this.index});
final int index;
void onTappedIndex(BuildContext contex, int index){

 switch(index){
  case 0: contex.go('/home/0');break;
  case 1: contex.go('/home/1');break;
  case 2: contex.go('/home/2');break;
 }
}
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: index,
      onTap:(index)=> onTappedIndex(context,index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorias',
          ),
           BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
          )
      ],
    );
  }
}