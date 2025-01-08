
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
     GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
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
      
      
  ]
  );