import 'package:cinemapedia/domain/datasources/series_datasource.dart';
import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:cinemapedia/domain/repositories/series_repository.dart';

class SerieRepositoryImpl extends SeriesRepository {
  final SeriesDatasource datasource;
  SerieRepositoryImpl(this.datasource);

  @override
  Future<List<Serie>> getOnAirSeries({int page = 1}) {
    return datasource.getOnAir(page: page);
  }

  @override
  Future<List<Serie>> searchSeries(String query) {
    return datasource.searchSeries(query);
  }
  
  @override
  Future<List<Serie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Serie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

   @override
  Future<Serie> getSerieById(String id) {
    return datasource.getSerieById(id);
  }
}