import 'package:flutter/material.dart';
import 'package:movies_app/bloc/person_bloc.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/models/person_response.dart';
import 'package:movies_app/screens/personDetailScreen.dart';
import 'package:movies_app/widgets/personInfo.dart';

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    super.initState();
    personBloc.getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text(
              "TRENDING PERSONS ON THIS WEEK",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder<PersonResponse>(
              stream: personBloc.subject.stream,
              builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
                if (snapshot.hasData) {
                  return _buildHomeWidget(snapshot.data!);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ]);
  }

  Widget _buildHomeWidget(PersonResponse data) {
    List<Person> persons = data.persons;
    if (persons.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Persons",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 200.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100.0,
              child: GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonInfo(id: persons[index].id),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      persons[index].profileImg == null
                          ? Hero(
                              tag: persons[index].id,
                              child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Hero(
                              tag: persons[index].id,
                              child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w300/" +
                                                persons[index].profileImg)),
                                  )),
                            ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        persons[index].name,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        "Trending for " + persons[index].known,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 9.0),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}
