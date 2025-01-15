
import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MoviesRepository{

  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getUpComing({int page = 1});
  Future<List<Movie>> getSimilar({int page = 1,required String id});
  Future<List<Movie>> searchMovie(String query);
   //pelicula indivual

  Future<Movie> getMovieById(String id);

}