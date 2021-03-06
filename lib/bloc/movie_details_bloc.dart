import 'package:flutter/material.dart';
import 'package:movies_app/models/movieDetailResponse.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<MovieDetailResponse> _subject =
      BehaviorSubject<MovieDetailResponse>();

  getMovieDetail(int id) async {
    MovieDetailResponse response = await _apiManager.getMovieDetail(id);
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

  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}

final movieDetailBloc = MovieDetailBloc();
