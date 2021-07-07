import 'movieList.dart';

class MovieListResponse {
  final List<Movie> movies;
  final String errors;

  MovieListResponse(this.movies, this.errors);

  MovieListResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((e) => new Movie.fromJson(e))
            .toList(),
        errors = "";

  MovieListResponse.withErrors(String errorValue)
      : movies = [],
        errors = errorValue;
}
