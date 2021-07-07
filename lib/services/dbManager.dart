import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/firebaseModels/favorite.dart';
import 'package:movies_app/firebaseModels/user.dart';
import 'package:movies_app/models/movieList.dart';

class DatabaseService {
  final String userid;
  DatabaseService({required this.userid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference favoriteList =
      FirebaseFirestore.instance.collection('favorites');

  Future createUserWithEmail(String name) async {
    return await userCollection
        .doc(userid)
        .set({'name': name, 'movieList': []});
  }

  Future updateFavorite(int mId, String title, String poster) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // String uid = auth.currentUser!.uid.toString();

    var userSnapshot = await userCollection.doc(userid).get();

    var datas = userSnapshot.data()!;
    // print(datas);
    // print(datas.keys.elementAt(1));
    datas[datas.keys.elementAt(1)]
        .add({'mId': mId, 'title': title, 'poster': poster});
    // var add = datas[datas.keys.elementAt(1)] = mId;

    // userCollection.add({'mId': mId});
    return await userCollection.doc(userid).update(datas);
    // return await add;
  }

  Future removeFavorite(int mId, String title, String poster) async {
    var userSnapshot = await userCollection.doc(userid).get();
    var datas = userSnapshot.data()!;
    // FirebaseFirestore
    // datas[datas.keys.elementAt(1)]
    datas[datas.keys.elementAt(1)] =
        datas[datas.keys.elementAt(1)].where((item) {
      return item['mId'] != mId;
    }).toList();
    // .arrayRemove({'mId': mId, 'title': title, 'poster': poster});

    return await userCollection.doc(userid).update(datas);
    // return await add;
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var items = snapshot.data()!['movieList'];
    // var userId = snapshot.id;
    List<Favorite> favorites = [];
    items.forEach((item) {
      Favorite newFavorite = Favorite(
          movieId: item['mId'], title: item['title'], poster: item['poster']);

      favorites.add(newFavorite);
    });
    return UserData(
      name: snapshot.data()!['name'],
      favorites: favorites,
    );
  }

  FavoriteList _favoriteDataFromSnapshot(DocumentSnapshot snapshot) {
    var items = snapshot.data()!['movieList'];
    List<Favorite> favorites = [];
    items.forEach((item) {
      Favorite newFavorite = Favorite(
          movieId: item['mId'], title: item['title'], poster: item['poster']);
      favorites.add(newFavorite);
    });
    return FavoriteList(favorites);
  }

  Stream<UserData> get userData {
    return userCollection.doc(userid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<FavoriteList> get favoriteData {
    return favoriteList.doc(userid).snapshots().map(_favoriteDataFromSnapshot);
  }
}
