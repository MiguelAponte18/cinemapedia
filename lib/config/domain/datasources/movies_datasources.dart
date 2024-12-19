
import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MoviesDatasources {

  Future<List<Movie>> getNowPlaying({int page = 1});
}