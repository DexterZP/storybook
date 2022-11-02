import 'package:get/get.dart';

import 'package:storybook/package/lib/flutterbook.dart';
import 'package:storybook/views/components/components.dart';

class StoryController extends GetxController {
  var components = RxList<Category>();

  @override
  void onInit() {
    super.onInit();

    //Components
    components.add(
      Category(
        categoryName: "Components",
        organizers: ComponentsWidget.folders,
      ),
    );
    //Compositions
  }
}
