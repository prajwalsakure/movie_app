import 'package:flutter/foundation.dart';
import 'package:movies_app/models/personDetailResp.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class PersonDetailBloc {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<PersonDetailResponse> _subject =
      BehaviorSubject<PersonDetailResponse>();

  getPersonDetails(int id) async {
    PersonDetailResponse response = await _apiManager.getPersonDetails(id);
    _subject.sink.add(response);
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<PersonDetailResponse> get subject => _subject;
}

final personDetailBloc = PersonDetailBloc();
