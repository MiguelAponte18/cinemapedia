import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/domain/entities/movie.dart';
import '../../providers/actors/actors_provider.dart';
import '../../widgets/widgets.dart';


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
       ref.read(similarMoviesProvider.notifier).loadNextPage(widget.movieid);
       
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
                  movie.posterPath ,
                  width: size.width * 0.3,
                  fit: BoxFit.cover,
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
                    Text(movie.overview,),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: MovieRating(voteAverage: movie.voteAverage),
                    )
                  ],
                ),
              ),

              

            ],
          ),
        ),
         
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child:  RichText(
            
            text: TextSpan(
              text:  'Estreno: ',
             style: textStyle.bodyLarge!.copyWith(fontWeight:FontWeight.bold),
            //  TextStyle(color: Color.fromARGB(255, 17, 17, 17),fontWeight: FontWeight.bold, fontSize: 17),
              children: [
                TextSpan(
                  
                  text: movie.releaseDate.isNotEmpty? movie.releaseDate: 'Sin datos',
                  style: const TextStyle(fontWeight: FontWeight.normal,)
                )
              ]
              ),
          
        
            )
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


            _CustomActors(movieid: movie.id.toString()),
           VideosFromMovie(movieId: movie.id),
        const SizedBox(height: 5,),
      _SimilarMovies(movie.id.toString()),
        
      const SizedBox(height: 50,)
      
      ],
    );
  }
}


class _SimilarMovies extends ConsumerWidget {
  const _SimilarMovies(this.movieId,);
 final String movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(similarMoviesProvider);
    return  MovieHorizontalListview(
    movies:movies,
    title: 'Recomendaciones',
     );
  }
}

class _CustomActors extends ConsumerWidget {
  const _CustomActors({ required this.movieid});
 final String movieid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final List<Actor>? actors = ref.watch(actorProvider)[movieid];
  final textStyle = Theme.of(context).textTheme;

   if(actors == null) return  const SizedBox();

    return  Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
               child: Text('Actores',style:textStyle.titleLarge),
            ),
            SizedBox(
                  height: 260,
              
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
                            
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInRight(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: FadeInImage(
                                      image: NetworkImage(
                                      actor.profilePath != ''? actor.profilePath : 'https://vectorified.com/images/no-profile-picture-icon-38.jpg',
                                    ),
                                      fit: BoxFit.cover,
                                      width:135, 
                                      height: 180,
                                      placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                                      ) 
                                    
                                 
                                      ),
                                  ),
                               const SizedBox(height: 5,),
                                Text(actor.name,maxLines: 2, ),
                                Text(actor.character?? '',maxLines: 1,style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)
            
                              ],
                            ),
                          
                          );
                        
                        }),
                    
                ),
          ],
        ),
      
    );
  }
}
final isFavoriteFutureProvider = FutureProvider.family.autoDispose((ref, int movieId) { //el.family para pasar un argumento y el .autodispose para reiniciar al estado inicial cada vez que vuelva a entrar en la vista
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return localStorageRepository.isMovieFavorite(movieId);
},);

class _CustomSliverAppBar extends ConsumerWidget {
  const _CustomSliverAppBar({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
 
    final size = MediaQuery.of(context).size;//dimensioines del dispositivo
    final isFavorite =  ref.watch(isFavoriteFutureProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height *0.7,//70% de la altura
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async{
             //reiniciamos el estado del provider para que vuelva a hacer la peticion
            await ref.read(favoritesMoviesNotifier.notifier).toggleFavoriteMovie(movie); //esperamos a que añada o quite la pelicula, para usar el invalidate
            
            ref.invalidate(isFavoriteFutureProvider); // vuelve el provider a su estado original, le decimos que se construya nuevamente
          },
           icon:isFavorite.when(//helper
            loading: () => const CircularProgressIndicator(),
            data: (isFavoriteData) => isFavoriteData? 
              const Icon(Icons.favorite, color: Colors.red,) 
             : const Icon(Icons.favorite_border),
             error: (_, __) => throw UnimplementedError(),
              ), 
           
          
            //                          
           ),
      ],
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
             
             loadingBuilder: (context, child, loadingProgress) {
               
               if(loadingProgress != null)return const SizedBox();
               return FadeIn(child: child);
             },
             
             ),
             
            ),
           
           //gradient para el poster entero
         const CustomGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [
                      Colors.transparent,
                      Colors.black38
                  ],
          stops:[0.7,1.0],//donde comienza y termina en la pantalla
          ),
         
        
         //gradient para que se mmuestre el corazon bien
          const CustomGradient(
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.bottomStart,
          colors: [
                      Colors.black87,
                      Colors.transparent,
                  ],
          stops:[0.0,0.3],
          ),
         
    
              //gradient para que se mmuestre la flecha bien
             const CustomGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              stops:[0.0,0.3],
              colors: [
                      Colors.black87,
                      Colors.transparent,
                    ] ,
              
              ),

          ],
        ),
      ),

    );
  }
}

