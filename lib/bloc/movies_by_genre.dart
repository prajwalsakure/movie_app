import 'package:flutter/material.dart';
import 'package:movies_app/models/movieListResponse.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class MovieListByGenre {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<MovieListResponse> _subject =
      BehaviorSubject<MovieListResponse>();
  getMoviesByGenre(int id) async {
    MovieListResponse response = await _apiManager.getMovieByGenre(id);
    _subject.sink.add(response);
  }

  // void drainStream() {
  //   _subject.value = null;
  // }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieListResponse> get subject => _subject;
}

final movieListByGenreBloc = MovieListByGenre();
