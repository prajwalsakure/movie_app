import 'package:flutter/material.dart';
import 'package:movies_app/bloc/person_details_bloc.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/widgets/personInfo.dart';

class PersonDetails extends StatefulWidget {
  final Person person;
  const PersonDetails({Key? key, required this.person}) : super(key: key);

  @override
  _PersonDetailsState createState() => _PersonDetailsState(person);
}

class _PersonDetailsState extends State<PersonDetails> {
  final Person person;
  _PersonDetailsState(this.person);
  @override
  void initState() {
    super.initState();
    // personDetailBloc..getPersonDetails(person.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [Text(person.name), PersonInfo(id: person.id)],
          ),
        ),
      ),
    );
  }
}
