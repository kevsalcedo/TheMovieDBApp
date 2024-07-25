import 'package:cinemapedia/domain/entities/serie.dart';

abstract class SeriesRepository {
  Future<List<Serie>> getOnAirSeries({int page = 1});

  Future<List<Serie>> getPopular({int page = 1});

  Future<List<Serie>> getTopRated({int page = 1});

  Future<Serie> getSerieById(String id);

  Future<List<Serie>> searchSeries(String query);
}
