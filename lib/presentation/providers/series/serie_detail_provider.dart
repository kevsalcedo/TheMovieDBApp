import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serieDetailProvider = StateNotifierProvider<SerieMapNotifier, Map<String, Serie>>((ref) {
  final getSerie = ref.watch(serieRepositoryProvider).getSerieById;
  return SerieMapNotifier(getSerie: getSerie);
});

typedef GetSerieCallback = Future<Serie> Function(String serieId);

class SerieMapNotifier extends StateNotifier<Map<String, Serie>> {
  final GetSerieCallback getSerie;

  SerieMapNotifier({required this.getSerie}): super ({});

  Future<void> loadSerie(String serieId) async {
    if (state[serieId] != null) return;
    final serie = await getSerie(serieId);
    state = {...state, serieId: serie};
  }

}