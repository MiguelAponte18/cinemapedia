import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/domain/entities/movie.dart';

class MovieHorizontalListview extends StatefulWidget {
  const MovieHorizontalListview({super.key, required this.movies, this.title, this.subTitle, this.loadNextPage,});
 final List<Movie> movies;
 final String? title;
 final String? subTitle;
 final VoidCallback? loadNextPage;

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
 
 
 
 final scrollController = ScrollController();

 @override
  void initState() {
    super.initState();
scrollController.addListener(() {
  if(widget.loadNextPage == null)return;
  if((scrollController.position.pixels +200)>= scrollController.position.maxScrollExtent){
    widget.loadNextPage!();//lo forzamos porque ya sabemos que viene porla condicion
  }

},);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
            if(widget.title != null|| widget.subTitle != null)
            _Title(title: widget.title,subtitle: widget.subTitle,),

            Expanded(child: ListView.builder(
            controller: scrollController,
             itemCount: widget.movies.length,
             scrollDirection: Axis.horizontal,
             physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
              ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({ required this.movie});
final Movie movie;


  @override
  Widget build(BuildContext context) {
    final themeTitle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
         //* Imagen
         
          SizedBox(
            width: 150,
            height: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath != 'no-poster'?movie.posterPath:'https://vectorified.com/images/no-profile-picture-icon-38.jpg',
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null){
                 return const SizedBox(
                  height: 190,
                   child: Center( child: CircularProgressIndicator(strokeWidth: 2,)),
                 );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/home/0/movie/${movie.id}'),  //asignandole la navegacion a la imagen con el paramtro de la id de la pelicula
                    child: FadeIn(child: child)
                    );
                },
              ),
            ),
          ),

        //*

        //* title 
        SizedBox(  
          width: 150,
          child: Text(
            movie.title,
            maxLines: 2,
            style: themeTitle.titleSmall,
          ),
        ),

          //* Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                const Icon(Icons.star_half_outlined, color: Color.fromARGB(255, 209, 189, 4)),
               const SizedBox(width: 3,),
                Text(movie.voteAverage.toStringAsFixed(1),style:themeTitle.bodyMedium!.copyWith(color:Color.fromARGB(255, 209, 189, 4) ),),
                 const SizedBox(width: 10,),
                 const Spacer(),
                 Text(HumanFormats.number(movie.popularity),style: themeTitle.bodySmall,)
              ],
            ),
          ),

        ],
      )
      );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key, this.title, this.subtitle});

final String? title;
final String? subtitle;
  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
         if(title!= null)
           Text(title!,style: titleStyle,),
           const Spacer(),
         if(subtitle!= null)
           FilledButton(
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact
            ),
            onPressed: () {},
             child: Text(subtitle!),
             )

        ],
      ),
    );
  }
}