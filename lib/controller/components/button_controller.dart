import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storybook/package/lib/flutterbook.dart';
import 'package:storybook/views/components/buttons/basic_button_widget.dart';

class ButtonController extends GetxController {
  static Component get pzlButtonStory => Component(
        componentName: 'Button',
        states: [
          ComponentState.child(
            stateName: 'PZLButton',
            codeSample: "lib/views/components/buttons/basic_button_widget.dart",
            docWeb:
                "https://share-docs.clickup.com/3084385/p/h/2y431-52400/b1a4361bc8fbbe5",
            child: const Center(
              child: PZLButton(
                color: Colors.red,
                child: Text("Clique aqui"),
              ),
            ),
          ),
        ],
      );
}
