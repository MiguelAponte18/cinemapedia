




import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
{
'545345': Movie(),  hacienod el cache si la pelicula ya la solicite, regresa el movie, sino crea una nueva
'545345': Movie(),
'545345': Movie(),
'545345': Movie(),
'545345': Movie(),
}
*/


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>((ref) {
  
  final movierepository = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieMapNotifier(getMovie: movierepository);
},);


typedef GetMovieCallBack = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>>{
GetMovieCallBack getMovie;


MovieMapNotifier({
  required this.getMovie
}): super({});//inicializando con un arrreglo vacio


Future<void> loadMovie(String movieId) async{

  if(state[movieId] != null)return;// si la pelicula ya existe, no va a hacer nadad
  
  final movie = await getMovie(movieId);
  state = {...state, movieId:movie}; //hace la copia del estado anterior y le agrega la pelicula
}


}