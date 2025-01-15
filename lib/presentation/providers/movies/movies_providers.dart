

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {//La clase MoviesNotifier la contrala y list<Movie> es la data o estado que fluye e el

final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
},);


//Estamos creando yna segunda instancia de una misma clase, con provider solo nose puede hacer, pero riverpod si

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {//La clase MoviesNotifier la contrala y list<Movie> es la data o estado que fluye e el

final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
},);


final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {//La clase MoviesNotifier la contrala y list<Movie> es la data o estado que fluye e el

final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
},);

final upComingMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {//La clase MoviesNotifier la contrala y list<Movie> es la data o estado que fluye e el

final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComing;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
},);




typedef MovieCallback = Future<List<Movie>> Function({int page});//para definir el caso de uso , que el movieNotifier va a necesitar para cargar mas peliculas


class MoviesNotifier extends StateNotifier<List<Movie>>{

  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool loading = false;

  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

Future<void> loadNextPage() async{
  if(loading) return;//para evitar que se agan varias peticiones simultaneas

  loading = true;

  currentPage++;
  final List<Movie> movies = await fetchMoreMovies(page:currentPage );//todo getNowPlaying
   state = [...state,...movies];
   await Future.delayed(const Duration(milliseconds: 300));//para reducir el numero de peticiones
   loading = false;
}

}


final similarMoviesProvider = StateNotifierProvider<MoviesNotifierSimilar,List<Movie>>((ref) {//La clase MoviesNotifier la contrala y list<Movie> es la data o estado que fluye e el

final fetchMoreMovies = ref.watch(movieRepositoryProvider).getSimilar;
  return MoviesNotifierSimilar(fetchMoreMovies: fetchMoreMovies);
},);



typedef MovieCallbackSimilar = Future<List<Movie>> Function({int page,required String id});//para definir el caso de uso , que el movieNotifier va a necesitar para cargar mas peliculas


class MoviesNotifierSimilar extends StateNotifier<List<Movie>>{

  int currentPage = 1;
  MovieCallbackSimilar fetchMoreMovies;
  bool loading = false;

  MoviesNotifierSimilar({
    required this.fetchMoreMovies
  }): super([]);

Future<void> loadNextPage( String id) async{
  if(loading) return;//para evitar que se agan varias peticiones simultaneas

  loading = true;

  // currentPage++;
  final List<Movie> movies = await fetchMoreMovies(page:currentPage,id: id );//todo getNowPlaying
   state = movies;
   await Future.delayed(const Duration(milliseconds: 300));//para reducir el numero de peticiones
   loading = false;
}

}