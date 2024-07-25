import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:cinemapedia/presentation/providers/series/series_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onAirSeriesProvider =
    StateNotifierProvider<SeriesNotifier, List<Serie>>((ref) {
  final fetchMoreSeries = ref.watch(serieRepositoryProvider).getOnAirSeries;

  return SeriesNotifier(fetchMoreSeries: fetchMoreSeries);
});

final popularSeriesProvider =
    StateNotifierProvider<SeriesNotifier, List<Serie>>((ref) {
  final fetchMoreSeries = ref.watch(serieRepositoryProvider).getPopular;

  return SeriesNotifier(fetchMoreSeries: fetchMoreSeries);
});

final topRatedSeriesProvider =
    StateNotifierProvider<SeriesNotifier, List<Serie>>((ref) {
  final fetchMoreSeries = ref.watch(serieRepositoryProvider).getTopRated;

  return SeriesNotifier(fetchMoreSeries: fetchMoreSeries);
});

typedef SerieCallback = Future<List<Serie>> Function({int page});

class SeriesNotifier extends StateNotifier<List<Serie>> {
  int currentPage = 0;
  bool isLoading = false;
  SerieCallback fetchMoreSeries;

  SeriesNotifier({
    required this.fetchMoreSeries,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;

    currentPage++;

    final List<Serie> series = await fetchMoreSeries(page: currentPage);
    state = [...state, ...series];
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    isLoading = false;
  }
}
