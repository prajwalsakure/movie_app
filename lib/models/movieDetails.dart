import 'genre.dart';

class MovieDetail {
  final int id;
  final bool adult;
  final int budget;
  final List<Genre> genres;
  final String releaseDate;
  final int runtime;
  final String posterPath;
  final String title;
  final String backPoster;
  final int reviews;
  final double rating;
  final double popularity;
  final String overview;

  MovieDetail(
      this.id,
      this.adult,
      this.budget,
      this.genres,
      this.releaseDate,
      this.runtime,
      this.posterPath,
      this.title,
      this.backPoster,
      this.overview,
      this.popularity,
      this.rating,
      this.reviews);

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        adult = json["adult"],
        budget = json["budget"],
        genres =
            (json["genres"] as List).map((e) => new Genre.fromJson(e)).toList(),
        releaseDate = json["release_date"],
        posterPath = json["poster_path"],
        title = json["title"],
        runtime = json["runtime"],
        overview = json["overview"],
        popularity = json["popularity"],
        rating = json["vote_average"],
        reviews = json["vote_count"],
        backPoster = json["backdrop_path"];
}
