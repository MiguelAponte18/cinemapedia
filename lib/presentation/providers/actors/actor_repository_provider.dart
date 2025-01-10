 

import 'package:cinemapedia/config/infrastructure/datasorces/actordb_datasource.dart';
import 'package:cinemapedia/config/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorDbDatasource());
},);