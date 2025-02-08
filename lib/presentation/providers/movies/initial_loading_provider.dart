
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref){
final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
final step2 = ref.watch(topRatedMoviesProvider).isEmpty;
final step3 = ref.watch(upComingMoviesProvider).isEmpty;


if(step1 || step2 || step3) return true;

return false; //terminamos de cargar 
});