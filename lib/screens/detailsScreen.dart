import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/bloc/movie_details_bloc.dart';
import 'package:movies_app/bloc/movie_video_bloc.dart';
import 'package:movies_app/models/movieDetailResponse.dart';
import 'package:movies_app/models/movieDetails.dart';
import 'package:movies_app/models/movieList.dart';
import 'package:movies_app/models/video.dart';
import 'package:movies_app/models/videoResponse.dart';
import 'package:movies_app/screens/homeScreen.dart';
import 'package:movies_app/screens/videoPlayer.dart';
import 'package:movies_app/services/dbManager.dart';
import 'package:movies_app/widgets/castList.dart';
import 'package:movies_app/widgets/movieDetail.dart';
import 'package:movies_app/widgets/movieInfo.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatefulWidget {
  // static const routeName = '/movie-info';
  // final int id;
  final Movie movie;
  MovieDetails({Key? key, required this.movie}) : super(key: key);
  @override
  _MovieDetailsState createState() => _MovieDetailsState(movie);
}

class _MovieDetailsState extends State<MovieDetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = '';
  final Movie movie;
  _MovieDetailsState(this.movie);
  @override
  void initState() {
    super.initState();
    // movieDetailBloc..getMovieDetail(id);
    movieVideosBloc..getMovieVideos(movie.id);
    uid = _auth.currentUser!.uid;
    fav(movie.id);
  }

  bool favrt = false;
  @override
  Widget build(BuildContext context) {
    return _movieDetails();
    // bool add = false;
    // return StreamBuilder<MovieDetailResponse>(
    //     stream: movieDetailBloc.subject.stream,
    //     builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot1) {
    //       if (snapshot1.hasData) {
    //         // movieDetailBloc..getMovieDetail(id);
    //         return _movieDetails(snapshot1.data!);
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     });
  }

  Future<void> fav(int ids) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    var user = await userCollection.doc(uid).get();
    var datas = user.data()!;
    // print(datas[datas.keys.elementAt(1)][1]['mId']);
    for (var id in datas[datas.keys.elementAt(1)]) {
      if (id['mId'] == ids) {
        setState(() {
          this.favrt = true;
        });

        break;
      }
    }
    // print(id['mId']);
  }

  Widget _movieDetails() {
    return Scaffold(
      body: new Builder(builder: (context) {
        return new SliverFab(
            floatingPosition: FloatingPosition(right: 20),
            floatingWidget: StreamBuilder<VideoResponse>(
                stream: movieVideosBloc.subject.stream,
                builder: (context, AsyncSnapshot<VideoResponse> snapshot2) {
                  if (snapshot2.hasData) {
                    return _buildVideo(snapshot2.data!);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            expandedHeight: 240,
            slivers: [
              new SliverAppBar(
                backgroundColor: Colors.grey,
                leading: ModalRoute.of(context)?.canPop == true
                    ? IconButton(
                        onPressed: () {
                          movieDetailBloc..dispose();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homeScreen()),
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
                      IconButton(
                        icon: Icon(favrt
                            ? Icons.favorite
                            : Icons.favorite_border_outlined),
                        color: Colors.red,
                        iconSize: 35,
                        onPressed: () {
                          setState(() {
                            if (!favrt) {
                              DatabaseService(userid: uid).updateFavorite(
                                  movie.id, movie.title, movie.poster);
                            } else {
                              DatabaseService(userid: uid).removeFavorite(
                                  movie.id, movie.title, movie.poster);
                            }
                            favrt = !favrt;
                          });
                        },
                        // FavoriteButton(
                        //   iconSize: 45,
                        //   isFavorite: false,
                        //   valueChanged: (_isFavorite) {
                        //     if (_isFavorite) {
                        //       favrt = _isFavorite;
                        //       DatabaseService(userid: uid).updateFavorite(
                        //           movie.id, movie.title, movie.poster);
                        //     }
                        //     // print('Is Favorite : $_isFavorite');
                        // },
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
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500" +
                                      movie.backPoster)),
                        ),
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.black.withOpacity(0.5)),
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
                  padding: EdgeInsets.all(4),
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
                  ))
            ]);
      }),
    );
  }

  Widget _buildVideo(VideoResponse data) {
    List<Video> videos = data.videos;
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayer(
                    controller: YoutubePlayerController(
                        initialVideoId: videos[0].key,
                        flags:
                            YoutubePlayerFlags(autoPlay: true, mute: true)))));
      },
      child: Icon(Icons.play_arrow),
    );
  }
}
