import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularesView extends ConsumerStatefulWidget {
  const PopularesView({super.key});

  @override
  PopularesViewState createState() => PopularesViewState();
}

class PopularesViewState extends ConsumerState<PopularesView> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final  moviesPopulares = ref.watch(popularMoviesProvider); //convirtiendo los valores a lista 
    // if(moviesPopulares.isEmpty){
    //   return const Center(
    //    child: CircularProgressIndicator(strokeWidth: 2,),
    //   );

    // }
    
    return Scaffold(
     
      body: MovieMasonry(
        movies: moviesPopulares,
        loadNexPage: ref.read(popularMoviesProvider.notifier).loadNextPage,
        )
      
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}