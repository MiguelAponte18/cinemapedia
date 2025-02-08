import 'package:cinemapedia/presentation/providers/theme/modo_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView( {super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin {
//ya tego acceco al ref con el consumerState

  @override
  void initState() {
    super.initState();
    ref.read(modoDarkProvider.notifier).activarModo();
    //como estoy dentro de un metodo es un read

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();



  }

  @override
  Widget build(BuildContext context) {
  super.build(context);
  
    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading)return FullScreenLoader();


    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider); //aqui si es watch porque necesito estar pendiente del estado
    final slideNowPlayingMovies = ref.watch(moviesSlideshowProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

    return CustomScrollView(
        slivers: [
          //los hijos de slivevers tienen que se widgets sliver
      
          //son widgets con caracteristicas de sliverr que es un widget especializadp  para trabajar con el Scrollview
      
          const SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
            ),
          ),
          SliverList(
              //sliverlist lo que me sirve para hacer la lista de widgets que tenia anteriormente
      
            delegate: SliverChildBuilderDelegate(
            // dalegate la funcion que que pide sliverlist que me va a sevir para retornar el cotenido que teniamos
            childCount: 1,
            (context, index) {
              return Column(
                  //si se desborda los hijos podemos usar SingleChildScrollView o en este caso si queremos comportamientos especiales del custombar, usamos CustomScrollViews, con los slivers
                  children: [
                    MoviesSlideshow(movies: slideNowPlayingMovies),
                    MovieHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'En cines',
                      subTitle: 'Lunes 20',
                      loadNextPage: () => ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage(), //el.red lo usamos cuando estamos dentro de callbacks o metodos
                    ),
                   
                    MovieHorizontalListview(
                      movies: upComingMovies,
                      title: 'Proximamente',
                      subTitle: 'En este mes',
                      loadNextPage: () => ref
                          .read(upComingMoviesProvider.notifier)
                          .loadNextPage(), //el.red lo usamos cuando estamos dentro de callbacks o metodos
                    ),
                  
                  
                    MovieHorizontalListview(
                      movies: topRatedMovies,
                      title: 'Mejor calificados',
                      subTitle: 'Desde siempre',
                      loadNextPage: () => ref
                          .read(topRatedMoviesProvider.notifier)
                          .loadNextPage(), //el.red lo usamos cuando estamos dentro de callbacks o metodos
                    ),
                  
                    const SizedBox(
                      height: 20,
                    )
                  ]);
            },
          )),
        ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
