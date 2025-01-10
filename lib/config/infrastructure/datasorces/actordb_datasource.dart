
import 'package:cinemapedia/config/domain/datasources/actors_datasorce.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/config/infrastructure/mappers/actors_mappers.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

import '../../constants/environment.dart';

class ActorDbDatasource extends ActorsDataSource {
final dio = Dio(BaseOptions(
      baseUrl:
          'https://api.themoviedb.org/3', //la base del url que nunca va a cambiar
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));
  

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    
    final response = await dio.get('/movie/$movieId/credits');

    final actorsdbResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = actorsdbResponse.cast
      .map(
          (actordb) => ActorsMappers.castFromToEntity(actordb)
        )
        .toList();
    
    return actors;
  }


}