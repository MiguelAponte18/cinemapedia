import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/theme/modo_dark.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {
  const MoviesSlideshow({super.key, required this.movies});

final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        scale: 0.9,//la escala de los siguientes
        viewportFraction: 0.8, //la visualicacion de los siguientes, entre mas bajo, mas se van a ver los slide proximos
        pagination: SwiperPagination(//tiene opciones hechas ya, pero esta es //para hacer la paginacion personalisada
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(//trabajos apartir de este diseño
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        itemCount: movies.length,
        autoplay: true,//parea que se mueva automaticamente
        itemBuilder: (context, index) => _Slide(movie: movies[index],)
        ),
    );
  }
}

class _Slide extends ConsumerWidget {
 const _Slide({
     required this.movie,
  });
  final Movie movie; 

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isdark = ref.watch(modoDarkProvider).isDarkMode;
    final decoration = BoxDecoration(
    
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: isdark? const Color.fromARGB(117, 238, 232, 232): const Color.fromARGB(174, 7, 5, 5),
        blurRadius: 10,
        offset: const Offset(0, 6)
      )
    ]

  );


    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Stack(
        children: [
          DecoratedBox(
          decoration: decoration,
          child: ClipRRect(//para hacer los bordes redondeados
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.backdropPath,
               fit: BoxFit.cover,
               loadingBuilder: (context, child, loadingProgress) {
                 if(loadingProgress!= null){
                  return const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black12
                    )
                    );    
                 }
                  return GestureDetector(
                  onTap: () => context.push('/home/0/movie/${movie.id}'),  //asignandole la navegacion a la imagen con el paramtro de la id de la pelicula
                   child: FadeIn(child: child)//retorna la imagen,
                  );
                  
                   
               },
            )
            )
            
          ),
          Padding(
            padding:const EdgeInsets.only(bottom: 3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const CustomGradient(
                begin: AlignmentDirectional.topCenter,
                 end: AlignmentDirectional.bottomCenter,
                  stops: [0.5, 1.0],
                 colors: [
                   Colors.transparent,
                   Colors.black87,
                 ]),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 20,
            child: Text(movie.title,style: const TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2.0,2.0),
                  blurRadius: 4.0,
                  color:Color.fromARGB(225, 0, 0, 0)

              )]),))
        ]
      ),
    );
  }
}