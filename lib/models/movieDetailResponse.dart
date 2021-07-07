import 'package:movies_app/models/movieDetails.dart';

class MovieDetailResponse {
  final MovieDetail movieDetail;
  final String error;
  MovieDetailResponse(this.movieDetail, this.error);
  MovieDetailResponse.fromJson(Map<String, dynamic> json)
      : movieDetail = MovieDetail.fromJson(json),
        error = "";
  MovieDetailResponse.withError(String errorVal)
      : movieDetail =
            MovieDetail(0, false, 0, [], '', 0, '', '', '', '', 0.0, 0.0, 0),
        error = errorVal;
}
