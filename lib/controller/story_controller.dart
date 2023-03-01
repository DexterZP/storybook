import 'package:get/get.dart';
import 'package:storybook/controller/folder_controller.dart';

import 'package:storybook/package/lib/flutterbook.dart';

class StoryController extends GetxController {
  List<Category> components = RxList<Category>();

  @override
  void onInit() {
    super.onInit();

    FolderController controller = Get.put(FolderController());

    //Components
    components.add(
      Category(
        categoryName: "Components",
        organizers: controller.folderComponent,
      ),
    );

    //Compositions
    components.add(
      Category(
        categoryName: "Compositions",
        organizers: controller.folderComposition,
      ),
    );
  }
}
