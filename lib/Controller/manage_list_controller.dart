import 'package:get/get.dart';
import 'package:tinder_clone/Data/data.dart';
import 'package:tinder_clone/Model/user.dart';

class ManageList extends GetxController {
  List<User> users = dummyUsers.obs;

  void removeList(User user) {
    users.remove(user);
  }

  void removeLast() {
    users.removeLast();
  }
}
