import 'package:movies_app/models/searchResponse.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<SearchResponse> _subject =
      BehaviorSubject<SearchResponse>();

  searchMovieList(String query) async {
    SearchResponse response = await _apiManager.getSearchList(query);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SearchResponse> get subject => _subject;
}

final searchListBloc = SearchBloc();
