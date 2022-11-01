import 'package:get/get.dart';
import 'package:storybook/views/components/buttons/pzl_button_widget.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class StoryController extends GetxController {
  var stories = RxList<Story>();

  @override
  void onInit() {
    super.onInit();

    //Components
    stories.add(Story(
        name: "Components/Buttons/Text",
        description: "PZLButton",
        builder: (_) => const PZLButtonWidget()));
    //Compositions
  }
}
