import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
   bool isLastPage=false;
   bool isLoading=false;
   bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async{
    if(isLastPage  || isLoading)return;
   isLoading = true;
    
    if(isFirstLoad){//llamando una vez mas la primera vez para que cargue 20 y permita hacer scroll
     await ref.read(favoritesMoviesNotifier.notifier).loadNextPage();
     isFirstLoad = false;
   }

      final movies = await ref.read(favoritesMoviesNotifier.notifier).loadNextPage();
     
  
    isLoading = false;

    if(movies.isEmpty){
     isLastPage = true; //si no devuelve mas pelicualas es porque estamos en la ultima pagina
    }
     
  }
  @override
  Widget build(BuildContext context) {
    final moviesFavorites = ref.watch(favoritesMoviesNotifier).values.toList(); //convirtiendo los valores a lista 
    return Scaffold(
     
      body: MovieMasonry(movies: moviesFavorites,loadNexPage: loadNextPage,)
      
    );
  }
}