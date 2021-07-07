import 'package:movies_app/models/genreResponse.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class GenreListBloc {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _apiManager.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresBloc = GenreListBloc();
