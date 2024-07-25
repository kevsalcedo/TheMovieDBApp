import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/series_datasource.dart';
import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:cinemapedia/infrastructure/mappers/serie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/serie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/seriedb_response.dart';
import 'package:dio/dio.dart';

class SeriedbDatasource extends SeriesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      },
    ),
  );

  List<Serie> _jsonToSeries(Map<String, dynamic> json) {
    final serieDBResponse = SerieDbResponse.fromJson(json);

    final List<Serie> series = serieDBResponse.results
        .where((seriedb) => seriedb.posterPath != 'no-poster')
        .map((seriedb) => SerieMapper.serieDBToEntity(seriedb))
        .toList();

    return series;
  }

   @override
  Future<List<Serie>> getOnAir({int page = 1}) async {
    final response = await dio.get(
      '/tv/on_the_air',
      queryParameters: {'page': page},
    );

    return _jsonToSeries(response.data);
  }

  @override
  Future<List<Serie>> searchSeries(String query) async {
    if (query.isEmpty) return [];

    final response = await dio.get(
      '/search/tv',
      queryParameters: {'query': query},
    );

    return _jsonToSeries(response.data);
  }
  
  @override
  Future<List<Serie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/tv/popular',
      queryParameters: {'page': page},
    );

    return _jsonToSeries(response.data);
  }
  
  @override
  Future<List<Serie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/tv/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonToSeries(response.data);
  }

  @override
  Future<Serie> getSerieById(String id) async {
    final response = await dio.get('/tv/$id');

    if (response.statusCode != 200)
      throw Exception("Serie with id: $id not found :(");

    final serieDetails = SerieDetails.fromJson(response.data);

    final Serie serie = SerieMapper.serieDetailsToEntity(serieDetails);

    return serie;
  }
 
}
