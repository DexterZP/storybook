import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook/controller/story_controller.dart';

import 'package:storybook/package/lib/flutterbook.dart';

class StoryBook extends StatelessWidget {
  StoryBook({Key? key}) : super(key: key);
  final controller = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return FlutterBook(
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      categories: [
        controller.components.first,
        Category(
          categoryName: "Compositions",
          organizers: [
            Folder(
              folderName: 'Dropdown',
              organizers: [
                Component(
                  componentName: 'Dropdown widget',
                  states: [
                    ComponentState.child(
                      stateName: 'Default Container',
                      child: Container(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
