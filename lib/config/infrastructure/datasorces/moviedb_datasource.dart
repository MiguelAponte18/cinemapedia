import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/config/infrastructure/mappers/movie_mappers.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/video.dart';
import '../mappers/video_mappers.dart';
import '../models/moviedb/video_moviedb.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(BaseOptions(
      baseUrl:
          'https://api.themoviedb.org/3', //la base del url que nunca va a cambiar
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
         
         .takeWhile((moviedb) =>
            moviedb.posterPath !=
            'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFoundReverse.jpg' ) //where es un filtro y si es true deja pasar la pelicula, sino, la excluye y no la tenemos que renderizar si no tiene poster
        .map(
          (moviedb) => MovieMappers.movieDBToEntity(moviedb),
        )
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
   
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpComing({int page = 1})async {
     final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});

    return _jsonToMovies(response.data);
  }
  
  
  @override
  Future<Movie> getMovieById(String id) async{
    
    final response =  await dio.get('/movie/$id');
   if(response.statusCode != 200) throw Exception('Movie with id: $id not found');
    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMappers.movieDetailstoEntity(movieDetails);

    return movie;
  }
  
  @override
  Future<List<Movie>> getSimilar({int page = 1, required String id})async{
   final response =
        await dio.get('/movie/$id/recommendations', queryParameters: {'page': page});
        if(response.statusCode != 200) throw Exception('Movie with id: $id not found');


    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) =>
            moviedb.posterPath !=
            'no-poster') //where es un filtro y si es true deja pasar la pelicula, sino, la excluye y no la tenemos que renderizar si no tiene poster
        .map(
          (moviedb) => MovieMappers.movieDBToEntity(moviedb),
        )
        .toList();


   return  movies;
  }
  
  @override
  Future<List<Movie>> searchMovie(String query) async {
   if(query.isEmpty)return [];

   final response =   await dio.get('/search/movie', queryParameters: {"query":query});

   return _jsonToMovies(response.data);

  }

  @override
  Future<List<Video>> getVideosById(int movieId)async {
    final response = await dio.get('/movie/$movieId/videos');

    final videosdbResponse = VideosResponse.fromJson(response.data);
  //  final videos = <Video>[];
   
 final List<Video> resultadosVideos =  videosdbResponse.results
   .where((video)=> video.site == 'YouTube')
   .map((videoDb)=>
    VideoMappers.videoFromEntity(videoDb)
   ).toList();
   
    // for(final videosResponse in videosdbResponse.results){
    //   if(videosResponse.site == 'Youtube'){
    //     final video = VideoMappers.videoFromEntity(videosResponse);

    //     videos.add(video);
    //   }

    // }

  

    return resultadosVideos;
  }
}
