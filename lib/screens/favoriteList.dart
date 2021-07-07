import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/firebaseModels/favorite.dart';
import 'package:movies_app/firebaseModels/user.dart';
import 'package:movies_app/widgets/favoriteTile.dart';
import 'package:provider/provider.dart';

class MyFavoriteList extends StatefulWidget {
  @override
  _MyFavoriteListState createState() => _MyFavoriteListState();
}

class _MyFavoriteListState extends State<MyFavoriteList> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    if (userData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final favorite = userData.favorites;
    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (BuildContext context) {
        return ListView.builder(
            itemCount: favorite.length,
            // reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return
                  //  MovieDetailCard(id: favorite[index].movieId);
                  FavoriteTile(
                favorite: favorite[index],
              );
            });
      }),
    );
  }
}
