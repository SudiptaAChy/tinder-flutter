import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinder_clone/Controller/button_controller.dart';
import 'package:tinder_clone/Controller/change_position_controller.dart';
import 'package:tinder_clone/Controller/manage_list_controller.dart';
import 'package:tinder_clone/Model/user.dart';
import 'package:tinder_clone/View/user_card.dart';

class Home extends StatelessWidget {
  final changePositionController = Get.put(ChangePositionController());
  final manageList = Get.put(ManageList());
  final buttonController = Get.put(ButtonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Obx(
        () => (manageList.users.length == 0)
            ? Center(child: Text('No users left'))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: manageList.users.map(userWidget).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.clear, size: 50.0, color: Colors.red),
                        onPressed: () {
                          buttonController.clearTap();
                          manageList.removeLast();
                          buttonController.resetButton();
                        },
                      ),
                      SizedBox(width: 30.0),
                      IconButton(
                        icon: Icon(Icons.favorite,
                            size: 50.0, color: Colors.cyan),
                        onPressed: () {
                          buttonController.loveTap();
                          manageList.removeLast();
                          buttonController.resetButton();
                        },
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget userWidget(User user) {
    bool topUser = (manageList.users.indexOf(user) ==
        manageList.users.length - 1); // only top of card user will get tag
    return Column(
      children: [
        Listener(
          onPointerUp: (details) {
            changePositionController.resetPosition();
          },
          onPointerDown: (details) {},
          onPointerMove: (details) {
            changePositionController.updatePosition(details.localDelta.dx);
          },
          onPointerCancel: (details) {
            changePositionController.resetPosition();
          },
          child: Draggable(
            child: Center(
                child: UserCard(
                    user: user,
                    topUser: topUser,
                    button: buttonController.button.toString())),
            feedback: Material(
              type: MaterialType.transparency,
              child: UserCard(
                  user: user,
                  topUser: topUser,
                  button: buttonController.button.toString()),
            ),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              if (details.offset.dx > 200) {
                // swipe right = liked her
                if (user.likeMe) showAlert();
                manageList.removeList(user);
              } else if (details.offset.dx < -200) {
                // swipe left = rejected her
                manageList.removeList(user);
              }
            },
          ),
        ),
      ],
    );
  }

  void showAlert() {
    Get.defaultDialog(
      title: 'It\'s A Match!',
      backgroundColor: Colors.black12.withOpacity(0.0),
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30.0),
      content: Text(''),
    );
  }
}
