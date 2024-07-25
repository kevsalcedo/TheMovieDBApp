import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';


final seriesSlideshowProvider = Provider<List<Serie>>((ref) {
  final onAirSeries = ref.watch(onAirSeriesProvider);

  if (onAirSeries.isEmpty) return [];

  return onAirSeries.sublist(0, 6);
});
