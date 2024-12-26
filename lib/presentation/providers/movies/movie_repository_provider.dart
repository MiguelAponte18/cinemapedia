import 'package:cinemapedia/config/infrastructure/datasorces/moviedb_datasource.dart';
import 'package:cinemapedia/config/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref){

  return MovieRepositoryImpl(MoviedbDatasource());
});// la data que conine este provider nunca va a cambiar
//solo lectura


