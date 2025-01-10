import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_provider.dart';
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
       ref.read(actorProvider.notifier).loadActors(widget.movieid);
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
  const _MovieDetails({required this.movie});
final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Padding(
          padding: const EdgeInsets.all(8),
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
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
              ) ,)
            ],
          ),
          ),


        const SizedBox(height: 30,),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20,),
           child: Text('Actores',style:textStyle.titleLarge),
        ),
       
      _CustomActors(movieid: movie.id.toString()),
        
      const SizedBox(height: 100,)
      
      ],
    );
  }
}

class _CustomActors extends ConsumerWidget {
  const _CustomActors({ required this.movieid});
 final String movieid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final List<Actor>? actors = ref.watch(actorProvider)[movieid];
   if(actors == null) return  const CircularProgressIndicator(strokeWidth: 2,);

    return  SizedBox(
          height: 300,
      
              child: ListView.builder(
              physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: actors.length,
              
                itemBuilder: (context, index) {
             

                 final actor = actors[index];
              
                 return Container(
                  width: 135,
                  padding: const EdgeInsets.symmetric(horizontal: 5),

                  child: Column(
                    
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            actor.profilePath != ''? actor.profilePath : 'https://vectorified.com/images/no-profile-picture-icon-38.jpg',
                            fit: BoxFit.cover,
                            width:135, 
                            height: 180,
                            loadingBuilder: (context, child, loadingProgress){
                              if (loadingProgress != null ) {
                                return  const SizedBox(
                                  height: 180,
                                  child: Center(child: CircularProgressIndicator(strokeWidth: 2,),));
                              } 
                              return child;
                            } ,
                            ),
                        ),
                       const SizedBox(height: 5,),
                        Text(actor.name,maxLines: 2,),
                        Text(actor.character?? '',maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)

                      ],
                    ),
                  
                  );
                
                }),
            
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
        // title: Text(movie.title,style: const TextStyle(
        //   color: Colors.white, fontSize: 20),
        //   textAlign: TextAlign.center, ),
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