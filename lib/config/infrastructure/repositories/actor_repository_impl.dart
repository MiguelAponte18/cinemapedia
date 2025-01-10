import 'package:cinemapedia/config/domain/datasources/actors_datasorce.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/config/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository{
  final ActorsDataSource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    
      return datasource.getActorsByMovie(movieId);
  }


}