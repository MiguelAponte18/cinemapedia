import '../entities/movie.dart';

abstract class LocalStorageDatasource {

  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int id);
  Future<List<Movie>> loadMovies( {int limited = 10, offset = 0});//limited para cargar de 19 eb 10 y ifffset oara la paginacion
  Future<bool> isThemeDark();
  Future<void> toggleThemeDark();
}