


import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searhQueryProvider  = StateProvider<String>((ref)=> '' );

final searchMovieProvider = StateNotifierProvider<SearchedMoviesNotifier,List<Movie> >((ref) {
  final movierepository = ref.watch(movieRepositoryProvider);
  return    SearchedMoviesNotifier(
     ref: ref,
     searchMovies: movierepository.searchMovie
     );
},

);

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>>{
final SearchMoviesCallback searchMovies;
final Ref ref;//tenemos que haceer referencia al widgetref

  SearchedMoviesNotifier(
  {
    required this.ref,
    required this.searchMovies}
  ):super([]);


  Future<List<Movie>> searchMoviesByQuery(String query) async{
  final List<Movie> movies = await searchMovies(query);
    ref.read(searhQueryProvider.notifier).state = query;
     state = movies;
    return movies;
  }


}