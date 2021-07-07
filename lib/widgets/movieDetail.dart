import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/bloc/movie_details_bloc.dart';
import 'package:movies_app/models/movieDetailResponse.dart';
import 'package:movies_app/models/movieDetails.dart';
import 'package:movies_app/screens/homeScreen.dart';
import 'package:movies_app/services/dbManager.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'castList.dart';
import 'movieInfo.dart';

class MovieDetailAll extends StatefulWidget {
  final int id;
  const MovieDetailAll({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailAllState createState() => _MovieDetailAllState(id);
}

class _MovieDetailAllState extends State<MovieDetailAll> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = '';
  final int id;
  _MovieDetailAllState(this.id);
  @override
  void initState() {
    super.initState();
    movieDetailBloc..getMovieDetail(id);
    uid = _auth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse>(
        stream: movieDetailBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot) {
          if (snapshot.hasData) {
            return _movieDetailsPage(snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _movieDetailsPage(MovieDetailResponse data) {
    MovieDetail movie = data.movieDetail;
    bool add = false;
    return new SliverFab(
      floatingWidget: null,
      slivers: [
        new SliverAppBar(
          backgroundColor: Colors.grey,
          leading: ModalRoute.of(context)?.canPop == true
              ? IconButton(
                  onPressed: () {
                    // movieDetailBloc..dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => homeScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 28,
                  ),
                )
              : null,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" "),
                // IconButton(
                //   icon: Icon(movie.fav
                //       ? Icons.favorite
                //       : Icons.favorite_border_outlined),
                //   onPressed: () async {
                //     // movie.fav = true;
                //     await DatabaseService(userid: uid)
                //         .updateFavorite(movie.id);
                //   },
                FavoriteButton(
                  iconSize: 45,
                  isFavorite: add,
                  valueChanged: (_isFavorite) {
                    if (_isFavorite) {
                      add = _isFavorite;
                      DatabaseService(userid: uid)
                          .updateFavorite(id, movie.title, movie.posterPath);
                    }
                    //     // print('Is Favorite : $_isFavorite');
                  },
                ),
              ],
            ),
          ),
          expandedHeight: 240,
          pinned: true,
          flexibleSpace: new FlexibleSpaceBar(
            title: Text(
                movie.title.length > 35
                    ? movie.title.substring(0, 32) + "..."
                    : movie.title,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            background: Stack(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://image.tmdb.org/t/p/w500" +
                            movie.backPoster)),
                  ),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.1,
                          0.9
                        ],
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.0)
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
            padding: EdgeInsets.all(5),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      'OVERVIEW',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      movie.overview +
                          movie.overview +
                          movie.overview +
                          movie.overview,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  MovieInfo(id: movie.id),
                  CastList(id: movie.id),
                ],
              ),
            )),
      ],
    );
  }
}
