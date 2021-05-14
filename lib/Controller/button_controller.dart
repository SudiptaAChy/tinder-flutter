import 'package:get/get.dart';

class ButtonController extends GetxController {
  var button = 'NONE'.obs;

  void resetButton() {
    button.value = 'NONE';
  }

  void clearTap() {
    button.value = 'NOPE';
  }

  void loveTap() {
    button.value = 'LIKE';
  }
}
