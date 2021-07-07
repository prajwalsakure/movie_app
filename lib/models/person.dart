class Person {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;
  final String birthPlace;
  final String biography;
  final String birthday;

  Person(this.id, this.popularity, this.name, this.profileImg, this.known,
      this.biography, this.birthday, this.birthPlace);

  Person.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profile_path"],
        known = json["known_for_department"],
        birthPlace = json["place_of_birth"],
        biography = json["biography"],
        birthday = json["birthday"];
}
