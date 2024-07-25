


class Serie {
    bool adult;
    String backdropPath;
    List<String> genreIds;
    int id;
    List<String> originCountry;
    String originalLanguage;
    String originalName;
    String overview;
    double popularity;
    String posterPath;
    DateTime firstAirDate;
    String name;
    double voteAverage;
    int voteCount;

    Serie({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.firstAirDate,
        required this.name,
        required this.voteAverage,
        required this.voteCount,
    });
}