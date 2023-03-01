import 'package:get/get.dart';
import 'package:storybook/controller/components/button_controller.dart';

import 'package:storybook/package/lib/flutterbook.dart';

class FolderController extends GetxController {
  List<Folder> get folderComponent => [
        Folder(
          folderName: 'Classes',
          organizers: [
            ButtonController.pzlButtonStory,
          ],
        ),
      ];

  List<Folder> get folderComposition => [
        Folder(
          folderName: 'Classes',
          organizers: [],
        ),
      ];
}
