import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:cinemapedia/presentation/delegates/search_series_delegate.dart';
import 'package:cinemapedia/presentation/providers/search/search_series_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomSeriesAppbar extends ConsumerWidget {
  const CustomSeriesAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Pelispedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final searchedSeries = ref.read(searchedSeriesProvider);
                  final searchQuery = ref.read(searchSeriesQueryProvider);

                  showSearch<Serie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchSeriesDelegate(
                        initialSeries: searchedSeries,
                        searchSeries: ref
                            .read(searchedSeriesProvider.notifier)
                            .searchSeriesByQuery),
                  ).then((movie) {
                    if (movie == null) return;

                    context.push('/home/0/serie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
