import 'package:cinemapedia/config/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository{
 
 final MoviesDatasources datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    // TODO: implement getNowPlaying
return datasource.getNowPlaying(page: page);

  }

}