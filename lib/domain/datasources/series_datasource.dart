import 'package:cinemapedia/domain/entities/serie.dart';

abstract class SeriesDatasource {
  Future<List<Serie>> getOnAir({int page = 1});

  Future<List<Serie>> getPopular({int page = 1});
  
  Future<List<Serie>> getTopRated({int page = 1});

  Future<Serie> getSerieById(String id);

  Future<List<Serie>> searchSeries(String query);
}
