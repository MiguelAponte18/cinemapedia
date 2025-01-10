

import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorProvider = StateNotifierProvider<ActorMapNotifier,Map<String,List<Actor>>>((ref) {
  
  final actorRepository = ref.watch(actorRepositoryProvider).getActorsByMovie;
  return ActorMapNotifier(getMovie: actorRepository);
},);


typedef GetMovieCallBack = Future<List<Actor>>Function(String movieId);

class ActorMapNotifier extends StateNotifier<Map<String,List<Actor>>>{
GetMovieCallBack getMovie;


ActorMapNotifier({
  required this.getMovie
}): super({});//inicializando con un arrreglo vacio


Future<void> loadActors(String movieId) async{

   if(state[movieId] != null)return;// si la pelicula ya existe, no va a hacer nadad

  final actors = await getMovie(movieId);

  state = {...state,movieId:actors}; //hace la copia del estado anterior y le agrega la pelicula
}


}