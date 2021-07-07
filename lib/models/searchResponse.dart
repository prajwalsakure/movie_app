import 'package:movies_app/models/movieDetails.dart';
import 'package:movies_app/models/movieList.dart';

class SearchResponse {
  final List<Movie> movie;
  final String error;
  SearchResponse(this.movie, this.error);
  SearchResponse.fromJson(Map<String, dynamic> json)
      : movie = (json["results"] as List)
            .map((e) => new Movie.fromJson(e))
            .toList(),
        error = "";
  SearchResponse.withError(String errorVal)
      : movie = [],
        error = errorVal;
}
// class SearchResponse {
//   final List<MovieDetail> movie;
//   final String error;
//   SearchResponse(this.movie, this.error);
//   SearchResponse.fromJson(Map<String, dynamic> json)
//       : movie = (json["results"] as List)
//             .map((e) => new MovieDetail.fromJson(e))
//             .toList(),
//         error = "";
//   SearchResponse.withError(String errorVal)
//       : movie = [],
//         error = errorVal;
// }
