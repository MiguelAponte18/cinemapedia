import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:flutter/material.dart';

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

class _Slide extends StatelessWidget {
 _Slide({
    super.key, required this.movie,
  });
  final Movie movie; 

  
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.black45,
        blurRadius: 10,
        offset: Offset(0, 10)
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
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black12
                    )
                    );    
                 }
                  return FadeIn(child: child);//retorna la imagen
               },
            )
            )
            
          ),
          Positioned(
            left: 15,
            bottom: 15,
            child: Text(movie.title,style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2.0,2.0),
                  blurRadius: 4.0,
                  color:const Color.fromARGB(225, 0, 0, 0)

              )]),))
        ]
      ),
    );
  }
}