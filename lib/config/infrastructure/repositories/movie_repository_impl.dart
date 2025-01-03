import 'package:cinemapedia/config/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository{
 
 final MoviesDatasources datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
   return datasource.getNowPlaying(page: page);

  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);

  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);

  }
  
  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasource.getUpComing(page: page);

  }

  

}