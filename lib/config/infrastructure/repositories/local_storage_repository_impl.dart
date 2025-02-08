import 'package:cinemapedia/config/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl( this.datasource);

  @override
  Future<bool> isMovieFavorite(int id) {
    return   datasource.isMovieFavorite(id);
  }

  @override
  Future<List<Movie>> loadMovies({int limited = 10, offset = 0}) {
     return datasource.loadMovies(limited: limited,offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
   return datasource.toggleFavorite(movie);
  }
  
  @override
  Future<bool> isThemeDark() {
    return datasource.isThemeDark();
  }
  
  @override
  Future<void> toggleThemeDark() {
    return  datasource.toggleThemeDark();    
  }

}