import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/Controller/change_position_controller.dart';
import 'package:tinder_clone/Model/user.dart';

class UserCard extends StatelessWidget {
  final changePositionController = Get.put(ChangePositionController());

  final User user;
  final bool topUser;
  final String button;
  UserCard(
      {@required this.user, @required this.topUser, @required this.button});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      width: size.width * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: AssetImage(user.img),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 0.5)],
          gradient: LinearGradient(
            colors: [Colors.black12, Colors.black26],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            stops: [0.4, 1],
          ),
        ),
        child: Stack(
          children: <Widget>[
            (button != 'NONE' && topUser) ? showButtonTag() : Container(),
            Positioned(
              left: 10.0,
              right: 5.0,
              bottom: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${user.location}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.0),
                  ),
                  Text(
                    '${user.name}, ${user.age}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Text(
                    '${user.work}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ),
            if (topUser) swipeTag(),
          ],
        ),
      ),
    );
  }

  Widget showButtonTag() {
    return Center(
      child: Transform.rotate(
        angle: (button == 'LIKE') ? 0.5 : -0.5,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: (button == 'LIKE') ? Colors.green : Colors.pink,
                width: 3.0),
          ),
          child: Text(
            button,
            style: TextStyle(
                color: (button == 'LIKE') ? Colors.green : Colors.pink,
                fontSize: 55.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget swipeTag() {
    return Obx(() {
      var color;
      var text;
      if (changePositionController.direction.toString() == 'Right')
        text = 'LIKE';
      else if (changePositionController.direction.toString() == 'Left')
        text = 'NOPE';
      else
        text = 'NONE';
      if (changePositionController.direction.toString() == 'Right')
        color = Colors.green;
      else if (changePositionController.direction.toString() == 'Left')
        color = Colors.pink;
      if (text == 'NONE') return Container();
      return Center(
        child: Transform.rotate(
          angle: (text == 'LIKE') ? 0.5 : -0.5,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 3.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: color, fontSize: 55.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    });
  }
}
