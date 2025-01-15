

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import '../../config/domain/entities/movie.dart';
typedef SearchMoviesCallback = Future<List<Movie>> Function (String query);

class SearchMovieDelegate extends SearchDelegate<Movie?>{//lo que va a regresar
SearchMovieDelegate( {
  required this.initialMovies,
  required this.searchmovies
});
 List<Movie> initialMovies;
final SearchMoviesCallback searchmovies;
StreamController<List<Movie>> debounceMovies = StreamController.broadcast();//.broadcast para tener multiples listeners, si sabemos que va a ser un slo widguet lo usamos sin el .
StreamController<bool> isLoadingStream = StreamController.broadcast();

Timer? _debounceTimer; //es como si fuera el setTime de javascript

  @override
  get searchFieldLabel => 'Buscar Pelicula';
  @override
  
  List<Widget>? buildActions(BuildContext context) {//para construir las acciones
    //esto se dispara cada vez que escribimos, tenemos que tener cuaidado
  
    return  [

      StreamBuilder(
        stream: isLoadingStream.stream,
         builder: (context, snapshot) {
           if(snapshot.data == true){
            return  SpinPerfect(
        infinite: true,
        child: IconButton(
          onPressed:()=> query = '', ///query es la palabra reservada que ofrece searchdelagate para el valor de lo que eesta escrito
           icon: const Icon(Icons.refresh_rounded)
           ),
                );
           }

        return    
      FadeIn(
        animate: query.isNotEmpty,//caracteristica del animate do parar poner condiiciones en la animacion
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed:()=> query = '', ///query es la palabra reservada que ofrece searchdelagate para el valor de lo que eesta escrito
           icon: const Icon(Icons.clear)
           ),
      );

         },
        ),
      
     
   
    ];
  }


void clearStreams(){
  debounceMovies.close();
}


 Widget buildResultsAndSuggestions(){
  return StreamBuilder(
    initialData: initialMovies,

    stream: debounceMovies.stream,
     builder: (context, snapshot) {
       
       final movies = snapshot.data?? [];
       return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) => 
        _MovieView(
          movie: movies[index],
          onTapClose:(contex,movie){
            clearStreams();
            close(context, movie);
          },
          )
        );
     },
     );
 }

  @override
  Widget? buildLeading(BuildContext context) { //para contruir un icono o la parte del inicio

  
       
    return IconButton(
      onPressed:() { 
        clearStreams();
        close(context, null);

        }, //le mando null porque asumimos que la persona no quiere buscar nada y quiere regresar
       icon: const Icon(Icons.arrow_back_ios_rounded)
       );
  }

  @override
  Widget buildResults(BuildContext context) {//los resultados que aparecen cuando la persona apreta enter
     return buildResultsAndSuggestions();

  }

  void _onQueryChange(String query){
     isLoadingStream.add(true);
    //esta funcion se va a repetir muchas veces, la vamos a usar para no hacer tantas peticiones http
    // print('query cambio');

    if(_debounceTimer?.isActive?? false) _debounceTimer?.cancel(); //si esta activo el timer lo cancelaa

    _debounceTimer = Timer(const Duration(milliseconds: 500),()async{
      //aqui dentro se va a hacer la peticion http
      // if(query.isEmpty) {
      //   debounceMovies.add([]);//para que no se haga la peticion http cuando este vacio y para conservar los datos en pantalla hasta que la persona dege de escribir
      //   return;
      // }
     final movies = await searchmovies(query);
     initialMovies = movies; //siempre voy a tener movies en el initial
     debounceMovies.add(movies);
      isLoadingStream.add(false);

    },);
  }

  @override
  Widget buildSuggestions(BuildContext context) {//cuando la presona esta escribiendo
_onQueryChange(query);

   return buildResultsAndSuggestions();

  }

}


class _MovieView extends StatelessWidget {
  const _MovieView({super.key, required this.movie, required this.onTapClose});
final Movie movie;
final Function onTapClose;
  @override
  Widget build(BuildContext context) {
    final textStyle= Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () =>onTapClose(context,movie) ,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            //image
            SizedBox(
              width: size.width *0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress != null) return const Center(child: CircularProgressIndicator());
                    return FadeIn(child: child);
      
                  },
                ),
              ),
            ),
      
            //decripcion
      
            const SizedBox(width: 10,),
      
            SizedBox(
              width: size.width *0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                  Text(movie.title,style: textStyle.titleMedium,),
                  (movie.overview.length >100)? 
                  Text('${movie.overview.substring(0,100)}...'): Text(movie.overview),
      
                  Row(
                    children: [
                      const Icon(Icons.star_half_outlined,color: Color.fromARGB(255, 239, 180, 3),),
                      const SizedBox(width: 5,),
                      Text(HumanFormats.number(movie.voteAverage,1), style:textStyle.bodyMedium!.copyWith(color: const Color.fromARGB(255, 239, 180, 3)))
                    ],
                  )
      
                ],
              ),
            )
      
      
          ],
        ),
      ),
    );
  }
}