
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
     GoRoute(
      path: '/home/:page',//pasandole la pagina que quiero mostrar
      builder: (context, state) {
       final page = state.pathParameters['page']?? '0';//obteniendo el indice de la ruta

        return  HomeScreen(pageIndex:int.parse(page));
         },
      routes: [ //conocidas como rutas hijas, voy a poder devolver a la ruta padre, asi vaya directamente en la web al hijo, va  a estar conectado para regresar al padre
         
      GoRoute(
      path: 'movie/:id',//con lo dos puntos le digo que voy a ,amdar ese argumento id
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';


        return  MovieScreen(movieid: movieId);
      },
      ),

      ]
      ),
      
      
      GoRoute( //como necesitamos propocionar la ruta / por defecto hacemos que rediriga
        path: '/',  //le ponemos barra baja a los argumentos pra decir que no los necesitamos
        redirect: (_, __) => '/home/0', //redireccionando a nuestro path inicial
      ),
      
  ]
  );