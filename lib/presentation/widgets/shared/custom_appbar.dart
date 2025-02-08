import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/providers/theme/modo_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/domain/entities/movie.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ){
    final isDark = ref.watch(modoDarkProvider).isDarkMode;
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final theme = ref.watch(localStorageRepositoryProvider);
    return   SafeArea(
      bottom: false,
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
             Icon(Icons.movie_outlined,color: colors.primary,),
             const SizedBox(width: 5,),
              Text('Cinemapedia',style: titleStyle,),
              const Spacer(),//widget que se entira al mayor espacio disponible
              IconButton(
                onPressed:()async{
                
                 await  ref.read(localStorageRepositoryProvider).toggleThemeDark();
                  ref.read(modoDarkProvider.notifier).toggleDarkTheme();
                  
                  
                },
                 icon: Icon(isDark?Icons.light_mode : Icons.dark_mode)
                 ),
              IconButton(onPressed: () async{
                final searchMovies= ref.read(searchMovieProvider);
                final searchQuery = ref.read(searhQueryProvider);

              final movie = await showSearch<Movie?>(
                  query: searchQuery, //el valor que va a tener el query por defeto
                  context: context,
                   delegate: SearchMovieDelegate(
                    initialMovies: searchMovies,
                    searchmovies: ref.read(searchMovieProvider.notifier).searchMoviesByQuery
                   )
                   ); 
                 if(movie ==null || !context.mounted) return ;
                    
                  context.push('/home/0/movie/${movie.id}');
                    
                  
              }, 
              icon: const Icon(Icons.search)
              )
            ],
          ),
        ),
        )
      );
  }
}