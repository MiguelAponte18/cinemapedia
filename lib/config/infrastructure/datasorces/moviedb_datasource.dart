import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/config/infrastructure/mappers/movie_mappers.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasources{
 
 final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',//la base del url que nunca va a cambiar
    queryParameters: {
      'api_key':Environment.theMovieDbKey,
      'language': 'es-MX'
    }

  )
);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{


final response = await dio.get('/movie/now_playing');
final movieDBResponse = MovieDbResponse.fromJson(response.data);

final List<Movie> movies = movieDBResponse.results
.where((moviedb)=>moviedb.posterPath != 'no-poster')//where es un filtro y si es true deja pasar la pelicula, sino, la excluye y no la tenemos que renderizar si no tiene poster
.map(
  (moviedb) => MovieMappers.movieDBToEntity(moviedb),
  ).toList();
return movies;


  }

}