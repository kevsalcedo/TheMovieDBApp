import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_responde.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      },
    ),
  );
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    if(response.statusCode != 200) throw Exception("Cast with id: $movieId not found :(");

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

    return actors;
  }
  
  @override
  Future<List<Actor>> getActorsBySerie(String serieId) async {
    final response = await dio.get('/tv/$serieId/credits');

    if(response.statusCode != 200) throw Exception("Cast with id: $serieId not found :(");

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

    return actors;
  } 
}
