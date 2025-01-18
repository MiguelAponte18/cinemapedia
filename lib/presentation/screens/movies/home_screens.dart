import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../views/views.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key, required this.pageIndex});
 final int pageIndex;

 final viewRoutes = <Widget>[
  const HomeView(),
  const SizedBox(),
  const FavoritesView()
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(//eidget para preservar el estadoo de los hijos
        index: pageIndex,
        children: viewRoutes
      ),
      bottomNavigationBar: CustomBottomNavigation(index: pageIndex,),
    );
  }
}

