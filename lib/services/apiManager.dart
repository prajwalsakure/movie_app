import 'package:dio/dio.dart';
import 'package:movies_app/models/castResponse.dart';
import 'package:movies_app/models/genreResponse.dart';
import 'package:movies_app/models/movieDetailResponse.dart';
import 'package:movies_app/models/movieListResponse.dart';
import 'package:movies_app/models/personDetailResp.dart';
import 'package:movies_app/models/person_response.dart';
import 'package:movies_app/models/searchResponse.dart';
import 'package:movies_app/models/videoResponse.dart';

class ApiManager {
  final String apikey = 'e8c78d9978b92ac0611aa249ecaea28f';
  static String baseUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularCat = '$baseUrl/movie/popular';
  var getMoviesUrl = '$baseUrl/discover/movie';
  var getGenresUrl = '$baseUrl/genre/movie/list';
  var movieUrl = '$baseUrl/movie';
  var searchUrl = '$baseUrl/search/movie';
  var getPersonUrl = '$baseUrl/trending/person/week';
  var getPersonDetail = '$baseUrl/person';
  //
  Future<MovieListResponse> fetchMovieList() async {
    var param = {"api_key": apikey, "language": "en-US", "page": 1};

    try {
      Response response = await _dio.get(getPopularCat, queryParameters: param);
      return MovieListResponse.fromJson(response.data);
    } catch (error, stackt) {
      print(stackt);
      return MovieListResponse.withErrors("$error");
    }
  }

  Future<GenreResponse> getGenres() async {
    var param = {"api_key": apikey, "language": "en-US", "page": 1};

    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: param);
      return GenreResponse.fromJson(response.data);
    } catch (error, stackt) {
      // print(e);
      return GenreResponse.withError("$error");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var param = {"api_key": apikey, "language": "en-US"};

    try {
      Response response =
          await _dio.get(movieUrl + "/$id", queryParameters: param);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stackt) {
      // print(e);
      return MovieDetailResponse.withError("$error");
    }
  }

  Future<MovieListResponse> getMovieByGenre(int id) async {
    var param = {
      "api_key": apikey,
      "language": "en-US",
      "page": 1,
      "with_genres": id
    };

    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: param);
      return MovieListResponse.fromJson(response.data);
    } catch (error, stackt) {
      // print(e);
      return MovieListResponse.withErrors("$error");
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var param = {
      "api_key": apikey,
      "language": "en-US",
    };

    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/credits",
          queryParameters: param);
      return CastResponse.fromJson(response.data);
    } catch (error, stackt) {
      // print(e);
      return CastResponse.withError("$error");
    }
  }

  Future<SearchResponse> getSearchList(String query) async {
    var param = {
      "api_key": apikey,
      "page": 1,
      "query": query,
    };

    try {
      Response response = await _dio.get(searchUrl, queryParameters: param);
      return SearchResponse.fromJson(response.data);
    } catch (error, stackt) {
      // print(e);
      return SearchResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {"api_key": apikey, "language": "en-US"};
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/videos",
          queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {"api_key": apikey};
    try {
      Response response = await _dio.get(getPersonUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<PersonDetailResponse> getPersonDetails(int id) async {
    var params = {"api_key": apikey};
    try {
      Response response =
          await _dio.get(getPersonDetail + "/$id", queryParameters: params);
      return PersonDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonDetailResponse.withError("$error");
    }
  }
}
