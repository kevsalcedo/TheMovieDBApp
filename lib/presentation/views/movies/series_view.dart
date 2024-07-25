import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/providers/series/series_slidershow_provier.dart';
import 'package:cinemapedia/presentation/widgets/series/series_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/series/series_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_series_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeriesView extends ConsumerStatefulWidget {
  const SeriesView({super.key});

  @override
  _SeriesViewState createState() => _SeriesViewState();
}

class _SeriesViewState extends ConsumerState<SeriesView> {
  @override
  void initState() {
    super.initState();

    ref.read(onAirSeriesProvider.notifier).loadNextPage();
    ref.read(popularSeriesProvider.notifier).loadNextPage();
    ref.read(topRatedSeriesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    /* final initialLoading = ref.watch(seriesLoadingProvier);

    if (initialLoading) return const FullScreenLoader(); */

    final slideshowSeries = ref.watch(seriesSlideshowProvider);
    final onAirSeries = ref.watch(onAirSeriesProvider);
    final popularSeries = ref.watch(popularSeriesProvider);
    final topRatedSeries = ref.watch(topRatedSeriesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: CustomSeriesAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  SeriesSlideshow(series: slideshowSeries),
                  SeriesHorizontalListview(
                    series: onAirSeries,
                    title: "Al aire",
                    subTitle: "Nuevas temporadas",
                    loadNextPage: () => ref
                        .read(onAirSeriesProvider.notifier)
                        .loadNextPage(),
                  ),

                  SeriesHorizontalListview(
                    series: popularSeries,
                    title: "Populares",
                    loadNextPage: () => ref
                        .read(popularSeriesProvider.notifier)
                        .loadNextPage(),
                  ),

                  SeriesHorizontalListview(
                    series: topRatedSeries,
                    title: "Mejores clasificadas",
                    loadNextPage: () => ref
                        .read(topRatedSeriesProvider.notifier)
                        .loadNextPage(),
                  ),

                  const SizedBox(height: 10),
                ],
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}
