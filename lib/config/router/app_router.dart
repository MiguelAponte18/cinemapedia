
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    ShellRoute(//es como un goroute pero especia en el que se le puede pasar un widget hijo, uitil cuando usamos un botomnavigator y queremos navegar en el manteniendolo
     
     builder: (context, state, child) {
       return HomeScreen(childView: child);
     },
      routes: [

        GoRoute(
          path:'/',
          builder: (context, state) {
            return const HomeView();
          
          },
          routes: [
                 GoRoute(
                  path: 'movie/:id',//con lo dos puntos le digo que voy a ,amdar ese argumento id
                  builder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';
                    return  MovieScreen(movieid: movieId);
                  },
                  ),

          ]
          ),
          GoRoute(
          path:'/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
          ),
      ]
      
      ),

      //ruta padre/hijo
    //  GoRoute(
    //   path: '/',
    //   builder: (context, state) => const HomeScreen( childView: HomeView(),),
    //   routes: [ //conocidas como rutas hijas, voy a poder devolver a la ruta padre, asi vaya directamente en la web al hijo, va  a estar conectado para regresar al padre
         
    //   GoRoute(
    //   path: 'movie/:id',//con lo dos puntos le digo que voy a ,amdar ese argumento id
    //   builder: (context, state) {
    //     final movieId = state.pathParameters['id'] ?? 'no-id';


    //     return  MovieScreen(movieid: movieId);
    //   },
    //   ),
    //   ]
    //   ),
      
      
  ]
  );