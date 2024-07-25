import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';


final searchSeriesQueryProvider = StateProvider<String>((ref) => '');

final searchedSeriesProvider = StateNotifierProvider<SearchedSeriesNotifier, List<Serie>>((ref) {

  final serieRepository = ref.read( serieRepositoryProvider );

  return SearchedSeriesNotifier(
    searchSeries: serieRepository.searchSeries, 
    ref: ref
  );
});


typedef SearchSeriesCallback = Future<List<Serie>> Function(String query);

class SearchedSeriesNotifier extends StateNotifier<List<Serie>> {

  final SearchSeriesCallback searchSeries;
  final Ref ref;

  SearchedSeriesNotifier({
    required this.searchSeries,
    required this.ref,
  }): super([]);


  Future<List<Serie>> searchSeriesByQuery( String query ) async{
    
    final List<Serie> series = await searchSeries(query);
    ref.read(searchSeriesQueryProvider.notifier).update((state) => query);

    state = series;
    return series;
  }

}





