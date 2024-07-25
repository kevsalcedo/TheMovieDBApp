import 'package:cinemapedia/infrastructure/models/moviedb/serie_moviedb.dart';

class SerieDbResponse {
    int page;
    List<SerieMovieDB> results;
    int totalPages;
    int totalResults;

    SerieDbResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    SerieDbResponse copyWith({
        int? page,
        List<SerieMovieDB>? results,
        int? totalPages,
        int? totalResults,
    }) => 
        SerieDbResponse(
            page: page ?? this.page,
            results: results ?? this.results,
            totalPages: totalPages ?? this.totalPages,
            totalResults: totalResults ?? this.totalResults,
        );

    factory SerieDbResponse.fromJson(Map<String, dynamic> json) => SerieDbResponse(
        page: json["page"],
        results: List<SerieMovieDB>.from(json["results"].map((x) => SerieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

