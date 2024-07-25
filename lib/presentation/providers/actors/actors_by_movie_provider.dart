import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

final actorsBySerieProvider =
    StateNotifierProvider<ActorsBySerieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsBySerieNotifier(getActors: actorsRepository.getActorsBySerie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}

typedef GetActorsBySerieCallback = Future<List<Actor>> Function(String serieId);

class ActorsBySerieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsBySerieCallback getActors;

  ActorsBySerieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String serieId) async {
    if (state[serieId] != null) return;

    final List<Actor> actors = await getActors(serieId);
    state = {...state, serieId: actors};
  }
}
