import 'package:movies_app/firebaseModels/favorite.dart';

class User {
  final String uid;
  User(this.uid);
}

class UserData {
  final List<Favorite> favorites;
  final String name;
  UserData({required this.name, required this.favorites});
  factory UserData.fromMap(Map<String, dynamic> userMap) {
    List<dynamic> favoriteList = userMap['favorites'];
    return UserData(
      name: userMap['name'],
      favorites: favoriteList.map((e) {
        return Favorite(
            movieId: e['movieId'], title: e['title'], poster: e['poster']);
      }).toList(),
    );
  }
  Map<String, dynamic> toMap() {
    var userMap = {
      'favorites': favorites.map((e) {
        return {'movieId': e.movieId, 'title': e.title, 'poster': e.poster};
      }).toList(),
    };
    return userMap;
  }
}
