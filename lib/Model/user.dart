import 'package:flutter/cupertino.dart';

class User {
  String name;
  int age;
  String img;
  String work;
  String location;
  bool likeMe;

  User(
      {@required this.name,
      @required this.age,
      this.img,
      this.work,
      this.location,
      @required this.likeMe});
}
