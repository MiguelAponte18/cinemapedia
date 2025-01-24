 

import 'package:cinemapedia/config/infrastructure/datasorces/isar_local_storage_datasource.dart';
import 'package:cinemapedia/config/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  
  return LocalStorageRepositoryImpl(IsarLocalStorageDatasource());
},);