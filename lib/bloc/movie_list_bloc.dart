import 'package:movies_app/models/movieListResponse.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class MovieListBloc {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<MovieListResponse> _subject =
      BehaviorSubject<MovieListResponse>();

  fetchMovieList() async {
    MovieListResponse response = await _apiManager.fetchMovieList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieListResponse> get subject => _subject;
}

final movieListBloc = MovieListBloc();
