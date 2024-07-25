

import 'package:cinemapedia/infrastructure/datasources/seriesdb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/serie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serieRepositoryProvider = Provider((ref){
  return SerieRepositoryImpl(SeriedbDatasource());
});
