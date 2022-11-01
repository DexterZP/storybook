import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook/controller/story_controller.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class StoryBook extends StatelessWidget {
  StoryBook({Key? key}) : super(key: key);
  final controller = Get.put(StoryController());

  @override
  Widget build(BuildContext context) {
    return Storybook(
      stories: controller.stories,
      plugins: initializePlugins(
        contentsSidePanel: true,
        knobsSidePanel: false,
        enableThemeMode: false,
        // initialDeviceFrameData: DeviceFrameData(
        //   device: Devices.ios.iPhone13,
        // ),
        enableKnobs: false,
      ),
    );
  }
}
