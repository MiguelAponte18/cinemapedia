import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../views/views.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key, required this.pageIndex});
 final int pageIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
 late    PageController pageControler; 

 @override
  void initState() {
        super.initState();
       pageControler = PageController(
        keepPage: true
       );
  }


  @override
  void dispose() {
    pageControler.dispose();
    super.dispose();

  }

 final viewRoutes = <Widget>[
  const HomeView(),
  const PopularesView(),
  const FavoritesView()
 ];


  @override
  Widget build(BuildContext context) {
     super.build(context);

    if ( pageControler.hasClients ) {
      pageControler.animateToPage(
        widget.pageIndex, 
        curve: Curves.easeInOut, 
        duration: const Duration( milliseconds: 250),
      );
    }

    return Scaffold(
      //metodo con indexedStack
      // body:IndexedStack(//eidget para preservar el estadoo de los hijos
      //   index: pageIndex,
      //   children: viewRoutes
      // ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),//para que no haga el scroll deslizando la pantalla

        controller: pageControler,
        children: viewRoutes
      ),
      bottomNavigationBar: CustomBottomNavigation(index: widget.pageIndex,),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

