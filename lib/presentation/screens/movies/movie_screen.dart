import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/domain/entities/movie.dart';


class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key, required this.movieid});
final String movieid; 

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override


  void initState() {
       super.initState();
       ref.read(movieInfoProvider.notifier).loadMovie(widget.movieid);
  }
  @override
  Widget build(BuildContext context) {
    final Movie?  movie = ref.watch(movieInfoProvider)[widget.movieid];
  
  if(movie == null)return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2,),));

    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomSliverAppBar(movie: movie,),

          SliverList(delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) => _MovieDetails(movie: movie,) ,
            )
            ),
        ],
      ),
      
    );
  }
}


class _MovieDetails extends StatelessWidget {
  const _MovieDetails({super.key, required this.movie});
final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                  ),
              ),

              const SizedBox(width: 10,),

              //descripcion
              SizedBox(
                width: (size.width - 40) * 0.7, //restandole un aproximado del espacio usado
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [
                    Text(movie.title,style: textStyle.titleLarge,),
                    Text(movie.overview)
                  ],
                ),
              ),

            ],
          ),
        ),


        //generos de la pelicula
        Padding(
          padding: EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
              ) ,)
            ],
          ),
          ),
        const SizedBox(height: 100,)
      
      ],
    );
  }
}



class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;//dimensioines del dispositivo


    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height *0.7,//70% de la altura
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(movie.title,style: const TextStyle(
          color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center, ),
        background: Stack( //un stack para añadir la imagen y agregar un gradient si la imagen es muy clara
          children: [

            SizedBox.expand(
             child: Image.network(
              movie.posterPath,
             fit: BoxFit.cover,
             
             ),
             
            ),
           
           //gradient para el poster entero
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  
                  
                  gradient: LinearGradient(
                   
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    stops: [0.4,1.0],//donde comienza y termina en la pantalla
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ]
                    )
                )
                ),
            ),

              //gradient para que se mmuestre la flecha bien
             const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(   
                  gradient: LinearGradient(          
                    begin: AlignmentDirectional.topStart,
                    stops: [0.0,0.3],//donde comienza y termina en la pantalla
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ]
                    )
                )
                ),
            )



          ],
        ),
      ),

    );
  }
}