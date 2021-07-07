import 'package:flutter/material.dart';
import 'package:movies_app/models/castResponse.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class CastsBloc {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<CastResponse> _subject =
      BehaviorSubject<CastResponse>();

  getCasts(int id) async {
    CastResponse response = await _apiManager.getCasts(id);
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

  BehaviorSubject<CastResponse> get subject => _subject;
}

final castsBloc = CastsBloc();
