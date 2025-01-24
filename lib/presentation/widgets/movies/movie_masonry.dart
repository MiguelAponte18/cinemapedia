//libreria grid de estilo pinterest
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets.dart';

class MovieMasonry extends StatefulWidget {
  const MovieMasonry({super.key, required this.movies,this.loadNexPage});
   final List<Movie> movies;
  final VoidCallback? loadNexPage;
  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
final scrollController = ScrollController();
  // init sc
  
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNexPage == null)return;
      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
         widget.loadNexPage!();
      }
    },);

  }
  

  @override
  void dispose() {
        scrollController.dispose();
        super.dispose();
  }

  //dispose
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,

        // physics: const BouncingScrollPhysics(),
        crossAxisCount: 3, //las colmnas que va a tener
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
         itemBuilder:(context, index) {
    
           if(index ==1){
            return Column(
              children: [
                const SizedBox(height: 30,),
                MoviePosterLink(movie:widget.movies[index])
              ],
            );
           }
           return MoviePosterLink(movie:widget.movies[index]);
         },
         ),
    );
  }
}