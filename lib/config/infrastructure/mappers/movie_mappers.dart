import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/movie_moviedb.dart';
//mappers es una capa de proteccion de la api que viene de afuera hacia nuestra aplicacion, para transformar la implementacion espeficifa de movieDb para transformarlo a mi entidad
//si ha un cambio en un futuro lo tendria que modificar aqui sin afectar a mi aplicacion
class MovieMappers {
  static Movie movieDBToEntity(MovieFromMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
      ?'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
      :'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      genreIds:moviedb.genreIds.map((e) =>e.toString() ).toList(),//lo hacemos asi para que se pueda poner tanto el id como el nombre del genero
      id: moviedb.id,
      originalLanguage:moviedb.originalLanguage,
      originalTitle:moviedb.originalTitle,
      overview:moviedb.overview,
      popularity:moviedb.popularity,
      posterPath:(moviedb.posterPath!= '')
      ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
      :'no-poster',
      releaseDate:moviedb.releaseDate,
      title:moviedb.title,
      video:moviedb.video,
      voteAverage:moviedb.voteAverage,
      voteCount:moviedb.voteCount
      );
}

              