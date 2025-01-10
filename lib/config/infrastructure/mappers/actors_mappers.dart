import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/credits_response.dart';

class ActorsMappers {
  static Actor castFromToEntity(Cast cast) => Actor(
    id: cast.id ,
    name: cast.name,
    profilePath: (cast.profilePath!= null )
    ?'https://image.tmdb.org/t/p/w500${cast.profilePath}':
     '',
    character: cast.character?? 'Sin papel especifico'
   );
}

