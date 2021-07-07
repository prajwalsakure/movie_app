class Movie {
  final int id;
  final double popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;
  final int reviews;
  bool fav;
  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.rating, this.reviews, this.fav);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble(),
        reviews = json["vote_count"],
        fav = false;
}

// To parse this JSON data, do
//
//     final movieList = movieListFromJson(jsonString);

// import 'dart:convert';

// MovieList movieListFromJson(String str) => MovieList.fromJson(json.decode(str));

// String movieListToJson(MovieList data) => json.encode(data.toJson());

// class MovieList {
//   MovieList({
//     this.page,
//     this.results,
//     this.totalPages,
//     this.totalResults,
//   });

//   int page;
//   List<Result> results;
//   int totalPages;
//   int totalResults;

//   factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
//         page: json["page"],
//         results:
//             List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//         totalPages: json["total_pages"],
//         totalResults: json["total_results"],
//       );

//   Map<String, dynamic> toJson() => {
//         "page": page,
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//         "total_pages": totalPages,
//         "total_results": totalResults,
//       };
// }

// class Result {
//   Result({
//     this.adult,
//     this.backdropPath,
//     this.genreIds,
//     this.id,
//     this.originalLanguage,
//     this.originalTitle,
//     this.overview,
//     this.popularity,
//     this.posterPath,
//     this.releaseDate,
//     this.title,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });

//   bool adult;
//   String backdropPath;
//   List<int> genreIds;
//   int id;
//   String originalLanguage;
//   String originalTitle;
//   String overview;
//   double popularity;
//   String posterPath;
//   DateTime releaseDate;
//   String title;
//   bool video;
//   double voteAverage;
//   int voteCount;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         adult: json["adult"],
//         backdropPath: json["backdrop_path"],
//         genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//         id: json["id"],
//         originalLanguage: json["original_language"],
//         originalTitle: json["original_title"],
//         overview: json["overview"],
//         popularity: json["popularity"].toDouble(),
//         posterPath: json["poster_path"],
//         releaseDate: DateTime.parse(json["release_date"]),
//         title: json["title"],
//         video: json["video"],
//         voteAverage: json["vote_average"].toDouble(),
//         voteCount: json["vote_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "adult": adult,
//         "backdrop_path": backdropPath,
//         "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
//         "id": id,
//         "original_language": originalLanguage,
//         "original_title": originalTitle,
//         "overview": overview,
//         "popularity": popularity,
//         "poster_path": posterPath,
//         "release_date":
//             "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
//         "title": title,
//         "video": video,
//         "vote_average": voteAverage,
//         "vote_count": voteCount,
//       };
// }
