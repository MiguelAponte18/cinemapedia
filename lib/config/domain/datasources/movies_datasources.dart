
import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MoviesDatasources {

  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getUpComing({int page = 1});



}