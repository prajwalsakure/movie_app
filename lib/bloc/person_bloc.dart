import 'package:movies_app/models/person_response.dart';
import 'package:movies_app/services/apiManager.dart';
import 'package:rxdart/rxdart.dart';

class PersonListBloc {
  final ApiManager _apiManager = ApiManager();
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPerson() async {
    PersonResponse response = await _apiManager.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personBloc = PersonListBloc();
