import 'package:cinemapedia/domain/entities/serie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/serie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/serie_moviedb.dart';

class SerieMapper {
  static Serie serieDBToEntity(SerieMovieDB seriedb) => Serie(
        adult: seriedb.adult,
        backdropPath: (seriedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${seriedb.backdropPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        genreIds: seriedb.genreIds.map((e) => e.toString()).toList(),
        id: seriedb.id,
        originCountry: seriedb.originCountry,
        originalLanguage: seriedb.originalLanguage,
        originalName: seriedb.originalName,
        overview: seriedb.overview,
        popularity: seriedb.popularity,
        posterPath: (seriedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${seriedb.posterPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        firstAirDate: seriedb.firstAirDate,
        name: seriedb.name,
        voteAverage: seriedb.voteAverage,
        voteCount: seriedb.voteCount,
      );

  static Serie serieDetailsToEntity(SerieDetails seriedb) => Serie(
        adult: seriedb.adult,
        backdropPath: (seriedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${seriedb.backdropPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        genreIds: seriedb.genres.map((e) => e.name).toList(),
        id: seriedb.id,
        originCountry: seriedb.originCountry,
        originalLanguage: seriedb.originalLanguage,
        originalName: seriedb.originalName,
        overview: seriedb.overview,
        popularity: seriedb.popularity,
        posterPath: (seriedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${seriedb.posterPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        firstAirDate: seriedb.firstAirDate,
        name: seriedb.name,
        voteAverage: seriedb.voteAverage,
        voteCount: seriedb.voteCount,
      );
}
