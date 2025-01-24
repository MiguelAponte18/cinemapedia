import 'package:cinemapedia/config/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalStorageDatasource extends LocalStorageDatasource {
late Future<Isar> db; //apertura de la base de dator, usamos late para esperar que este lista para ejeecutar lo siguiente

IsarLocalStorageDatasource(){
  db = openDB();//metodo que todavia no esta creado
}

Future<Isar> openDB() async{
final dir = await getApplicationDocumentsDirectory();

    if(Isar.instanceNames.isEmpty){//si  no tenemos ninguna instancia
    return await Isar.open( //abrimoms la base de datos, 
      [MovieSchema],
       inspector: true, //me permite levantar un servicio automaticamente por isar para ver el estado de la base de datos local
       directory:dir.path,
      );
    }

   return Future.value(Isar.getInstance()); //si ya tenemmos la instancia la retornamos, usamos esa base de datos abierta
}

  @override
  Future<bool> isMovieFavorite(int id)async {
    final isar = await db; //esperammos a la base de datos que este lista
          //lo hacemos opcional             //accedemos al esquema de movies
    final Movie? isFavoriteMovie = await isar.movies
          .filter()//le hacemos saber que vamos a aplicar un filtro
          .idEqualTo(id)//verificamos si el id es igual al que esta en la base de datos, isar construye metoso relacionados a las propiedadees de nuestra entidad
          .findFirst();//para que nos duvuelva el primero que encuentra (que es el que existe)
   
   return isFavoriteMovie != null; 
   }


  @override
  Future<void> toggleFavorite(Movie movie)async {
    final isar =await db;
      
    final favoriteMovie = await isar.movies
     .filter()
     .idEqualTo(movie.id) //buscamos la pelicula si existe
     .findFirst();

     if(favoriteMovie != null ){ //Borrar
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!),);//lo borramos el id que le asigno isar
     return;
     }
    //para borrar o insertar siempre vamos usar el .writeTxn o writeTxnSync 
     
     //transaccion es interracion con la base de datos

    //insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie),);
  }

  @override
  Future<List<Movie>> loadMovies({int limited = 10, offset = 0})async {
    final isar = await db;

    return isar.movies.where()//extraigo mediante el where o se puede usar filter tambuen
         .offset(offset)
         .limit(limited)
         .findAll(); //trae los objetos que se relacionan con los parametros que le pase

  }


}