import 'package:flutter/material.dart';
import 'package:movies_app/bloc/movie_details_bloc.dart';
import 'package:movies_app/models/movieDetailResponse.dart';
import 'package:movies_app/models/movieDetails.dart';

class MovieInfo extends StatefulWidget {
  final int id;
  MovieInfo({Key? key, required this.id}) : super(key: key);
  @override
  _MovieInfoState createState() => _MovieInfoState(id);
}

class _MovieInfoState extends State<MovieInfo> {
  final int id;
  _MovieInfoState(this.id);
  @override
  void initState() {
    super.initState();
    movieDetailBloc..getMovieDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse>(
        stream: movieDetailBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildMovieDetails(snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildMovieDetails(MovieDetailResponse data) {
    MovieDetail mDetail = data.movieDetail;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Icon(Icons.timer, size: 45, color: Colors.blue),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        mDetail.runtime.toString() + " min",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Icon(Icons.calendar_today, size: 45, color: Colors.blue),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        mDetail.releaseDate,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Icon(Icons.attach_money, size: 45, color: Colors.blue),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        (mDetail.budget / 1000000).toString() + " M",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "GENRES",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 38.0,
                  padding: EdgeInsets.only(right: 10.0, top: 10.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mDetail.genres.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border:
                                  Border.all(width: 1.0, color: Colors.black)),
                          child: Text(
                            mDetail.genres[index].name,
                            maxLines: 2,
                            style: TextStyle(
                                height: 1.4,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
