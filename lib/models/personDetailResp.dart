import 'package:movies_app/models/person.dart';

class PersonDetailResponse {
  final Person person;
  final String error;
  PersonDetailResponse(this.person, this.error);
  PersonDetailResponse.fromJson(Map<String, dynamic> json)
      : person = Person.fromJson(json),
        error = "";
  PersonDetailResponse.withError(String errorVal)
      : person = Person(0, 0.0, '', '', '', '', '', ''),
        error = errorVal;
}
