import 'package:flutter/material.dart';
import 'package:movies_app/models/videoResponse.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class MovieVideosBloc {
  final ApiManager _repository = ApiManager();
  final BehaviorSubject<VideoResponse> _subject =
      BehaviorSubject<VideoResponse>();

  getMovieVideos(int id) async {
    VideoResponse response = await _repository.getMovieVideos(id);
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

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();
