
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';





class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:_HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}


class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
//ya tego acceco al ref con el consumerState

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //como estoy dentro de un metodo es un read
    
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }
  @override
  Widget build(BuildContext context) {
    // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);//aqui si es watch porque necesito estar pendiente del estado
    final slideNowPlayingMovies = ref.watch(moviesSlideshowProvider);
    
    return Column(
      children: [
     
     const CustomAppbar(),
     MoviesSlideshow(movies: slideNowPlayingMovies),
  
      ]
     
    );
    
    
    }
}