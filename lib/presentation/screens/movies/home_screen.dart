import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        // Appbar
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            //remove left padding
            titlePadding: EdgeInsets.zero,
            title: CustomAppbar(),
          ),
        ),

        //Lists Views
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  //const CustomAppbar(),
                  MoviesSlideshow(movies: slideShowMovies),

                  /* Expanded(
              child: ListView.builder(
                itemCount: nowPlayingMovies.length,
                itemBuilder: (context, index) {
                  final movie = nowPlayingMovies[index];
                  return ListTile(
                    title: Text(movie.title),
                  );
                },
              ),
            ), */

                  MoviesHorizontalListview(
                    movies: nowPlayingMovies,
                    title: "En cines",
                    subTitle: "Abril 4",
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                  MoviesHorizontalListview(
                    movies: upcomingMovies,
                    title: "Proximamente",
                    //subTitle: "Abril 4",
                    loadNextPage: () => ref
                        .read(upcomingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                  MoviesHorizontalListview(
                    movies: topRatedMovies,
                    title: "Mejor calificadas",
                    //subTitle: "Abril 4",
                    loadNextPage: () => ref
                        .read(topRatedMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                  MoviesHorizontalListview(
                    movies: popularMovies,
                    title: "Populares",
                    //subTitle: "Abril 4",
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
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
