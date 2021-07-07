import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movies_app/bloc/person_details_bloc.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/models/personDetailResp.dart';
import 'package:movies_app/screens/personDetailScreen.dart';

class PersonInfo extends StatefulWidget {
  final int id;
  PersonInfo({Key? key, required this.id}) : super(key: key);

  @override
  _PersonInfoState createState() => _PersonInfoState(id);
}

class _PersonInfoState extends State<PersonInfo> {
  final int id;
  _PersonInfoState(this.id);
  @override
  void initState() {
    super.initState();
    personDetailBloc..getPersonDetails(id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PersonDetailResponse>(
        stream: personDetailBloc.subject.stream,
        builder: (context, AsyncSnapshot<PersonDetailResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildPersonDetails(snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildPersonDetails(PersonDetailResponse data) {
    Person pd = data.person;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(pd.biography),
                SizedBox(
                  height: 10,
                ),
                Text(pd.birthPlace),
                SizedBox(
                  height: 10,
                ),
                Text(pd.birthday)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
