import 'package:flutter/material.dart';
import 'package:movies_app/bloc/genres_bloc.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/genreResponse.dart';
import 'package:movies_app/widgets/genreList.dart';

class GenreScroll extends StatefulWidget {
  @override
  _GenreScrollState createState() => _GenreScrollState();
}

class _GenreScrollState extends State<GenreScroll> {
  @override
  void initState() {
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
        stream: genresBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildMainWidget(snapshot.data!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildMainWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return GenreList(genres: genres);
  }
}
