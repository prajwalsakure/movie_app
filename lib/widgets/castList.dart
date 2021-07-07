import 'package:flutter/material.dart';
import 'package:movies_app/bloc/cast_bloc.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/castResponse.dart';
import 'package:movies_app/screens/personDetailScreen.dart';
import 'package:movies_app/widgets/personInfo.dart';

class CastList extends StatefulWidget {
  final int id;
  CastList({Key? key, required this.id}) : super(key: key);
  @override
  _CastListState createState() => _CastListState(id);
}

class _CastListState extends State<CastList> {
  final int id;
  _CastListState(this.id);
  @override
  void initState() {
    super.initState();
    castsBloc..getCasts(id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text(
              "CASTS",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder<CastResponse>(
              stream: castsBloc.subject.stream,
              builder: (context, AsyncSnapshot<CastResponse> snapshot) {
                if (snapshot.hasData) {
                  return _buildMainWidget(snapshot.data!);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ]);
  }

  Widget _buildMainWidget(CastResponse data) {
    List<Cast> casts = data.casts;
    if (casts.length == 0) {
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
    } else {
      return Container(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: casts.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 90,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonInfo(id: casts[index].id),
                    ),
                  );
                },
                child: Column(
                  children: [
                    casts[index].img == null
                        ? Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.person_outline,
                              size: 70,
                            ),
                          )
                        : Container(
                            height: 70,
                            width: 70,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500" +
                                            casts[index].img))),
                          ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text(
                      casts[index].name,
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
                      casts[index].character,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
