import 'package:flutter/material.dart';
import 'package:movies_app/bloc/movie_details_bloc.dart';
import 'package:movies_app/firebaseModels/favorite.dart';
import 'package:movies_app/models/movieDetailResponse.dart';
import 'package:movies_app/models/movieDetails.dart';
import 'package:movies_app/screens/detailsScreen.dart';

// class FavoriteTile extends StatelessWidget {
//   final Favorite favorite;
//   FavoriteTile(this.favorite);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(child: Text(favorite.movieId.toString())),
//     );
//   }
// }
class FavoriteTile extends StatefulWidget {
  final Favorite favorite;
  FavoriteTile({Key? key, required this.favorite}) : super(key: key);

  @override
  _FavoriteTileState createState() => _FavoriteTileState(favorite);
}

class _FavoriteTileState extends State<FavoriteTile> {
  final Favorite favorite;
  _FavoriteTileState(this.favorite);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => MovieDetails(movie: favorite),
          //     ),
          //   );
          // },
          child: Card(
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500" +
                                  favorite.poster))),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  favorite.title.length > 30
                      ? favorite.title.substring(0, 27) + "..."
                      : favorite.title,
                )
              ],
            ),
          ),
        ));
  }
}
