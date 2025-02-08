





import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesMoviesNotifier = StateNotifierProvider<StorageMovieNotifier,Map<int,Movie>>((ref){
final localStorageRepository = ref.watch(localStorageRepositoryProvider);


return StorageMovieNotifier(localStorageRepository: localStorageRepository);

});

class StorageMovieNotifier extends StateNotifier<Map<int,Movie>> {

  LocalStorageRepository localStorageRepository;
   int page = 0;
  StorageMovieNotifier({
    required this.localStorageRepository,
  }):super({});


Future<List<Movie>> loadNextPage()async{
final movies = await localStorageRepository.loadMovies(offset: page * 10,); //lomitit 20
   page++;
   
   final tempMovies = <int,Movie>{};

   for (final movie in movies) {
      tempMovies[movie.id] = movie; //creando el mapa con todo el listado de peliculas para agregarlo al estado     
   }
    
   state = {...state,...tempMovies};
return movies;


}

Future<void> toggleFavoriteMovie(Movie movie) async{


  await localStorageRepository.toggleFavorite(movie);
  final bool isMovieInFavorite = state[movie.id] != null;

  if(isMovieInFavorite){
    state.remove(movie.id); //esto no sispara la renderizacione deñ widget, entonces debemos asignarle el nuevo valor
    state = {...state};
  }else{
    state = {...state,movie.id:movie};
  }
}



}