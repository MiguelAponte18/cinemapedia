



import 'package:cinemapedia/config/app_theme/app_theme.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 final modoDarkProvider = StateNotifierProvider<ThemeDark,AppTheme>((ref) {
  final storage = ref.watch(localStorageRepositoryProvider);
 return ThemeDark(localStorage:storage );
 },);



 class ThemeDark extends StateNotifier<AppTheme>{
  ThemeDark({ required this.localStorage}) :super(AppTheme());

  LocalStorageRepository localStorage;

 void activarModo()async{
final movie =  await localStorage.isThemeDark();
 state= state.copyWith(
    isDarkMode: movie
  );
 }


void toggleDarkTheme()async{
 await localStorage.toggleThemeDark();
 
  activarModo();
}

 }