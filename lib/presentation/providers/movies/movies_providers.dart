

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {//La clase MoviesNotifier la contrala y list<Movie> es la data o estado que fluye e el
  //TODO algo

final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
},);

typedef MovieCallback = Future<List<Movie>> Function({int page});//para definir el caso de uso , que el movieNotifier va a necesitar para cargar mas peliculas


class MoviesNotifier extends StateNotifier<List<Movie>>{

  int currentPage = 0;
  MovieCallback fetchMoreMovies;


  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

Future<void> loadNextPage() async{
  currentPage++;
  final List<Movie> movies = await fetchMoreMovies(page:currentPage );//todo getNowPlaying
   state = [...state,...movies];
}

}