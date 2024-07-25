import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:flutter/material.dart';

typedef SearchSeriesCallback = Future<List<Serie>> Function(String query);

class SearchSeriesDelegate extends SearchDelegate<Serie?> {
  final SearchSeriesCallback searchSeries;

  List<Serie> initialSeries;

  StreamController<List<Serie>> debouncedSeries = StreamController.broadcast();
  Timer? _debounceTimer;

  StreamController<bool> isLoadingStream = StreamController.broadcast();

  SearchSeriesDelegate({
    required this.searchSeries,
    required this.initialSeries,
  }) : super(
            searchFieldLabel: 'Buscar series',
            textInputAction: TextInputAction.search);

  void clearStreams() {
    debouncedSeries.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final series = await searchSeries(query);
      initialSeries = series;
      debouncedSeries.add(series);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialSeries,
      stream: debouncedSeries.stream,
      builder: (context, snapshot) {
        final series = snapshot.data ?? [];

        return ListView.builder(
          itemCount: series.length,
          itemBuilder: (context, index) => _SerieItem(
            serie: series[index],
            onSerieSelected: (context, serie) {
              clearStreams();
              close(context, serie);
            },
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
            if ( snapshot.data ?? false ) {
              return SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  infinite: true,
                  child: IconButton(
                    onPressed: () => query = '', 
                    icon: const Icon( Icons.refresh_rounded )
                  ),
                );
            }

             return FadeIn(
                animate: query.isNotEmpty,
                child: IconButton(
                  onPressed: () => query = '', 
                  icon: const Icon( Icons.clear )
                ),
              );

        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
}

class _SerieItem extends StatelessWidget {
  final Serie serie;
  final Function onSerieSelected;

  const _SerieItem({required this.serie, required this.onSerieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onSerieSelected(context, serie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  serie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 10),

            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(serie.name, style: textStyles.titleMedium),
                  (serie.overview.length > 100)
                      ? Text('${serie.overview.substring(0, 100)}...')
                      : Text(serie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(serie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
