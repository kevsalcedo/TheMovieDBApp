import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final seriesLoadingProvier = Provider<bool>((ref) {
  final step1 = ref.watch(onAirSeriesProvider).isEmpty;
  final step2 = ref.watch(popularSeriesProvider).isEmpty;
  final step3 = ref.watch(topRatedSeriesProvider).isEmpty;

  if (step1 || step2 || step3) return true;

  return false;
});
