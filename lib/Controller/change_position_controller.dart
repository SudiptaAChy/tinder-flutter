import 'package:get/get.dart';

class ChangePositionController extends GetxController {
  var direction = 'None'.obs;

  void resetPosition() {
    direction.value = 'None';
  }

  void updatePosition(double dx) {
    if (dx > 0)
      direction.value = 'Right';
    else if (dx < 0)
      direction.value = 'Left';
    else
      direction.value = 'None';
  }
}
