import 'package:flutter/cupertino.dart';
import 'package:storybook/package/lib/flutterbook.dart';

import 'buttons/pzl_button_widget.dart';

class ComponentsWidget {
  ComponentsWidget._();

  static List<Folder> get folders => [
        Folder(
          folderName: 'Inputs',
          organizers: [
            pzlButtonWidgetStory,
            containerStory,
          ],
        ),
      ];

  static Component get pzlButtonWidgetStory => Component(
        componentName: 'Dropdown',
        states: [
          ComponentState.child(
            stateName: 'Widget',
            codeSample: "lib/views/components/buttons/pzl_button_widget.dart",
            docWeb:
                "https://doc.clickup.com/3084385/p/h/2y431-52263/b70168854abd3c4",
            child: const PZLButtonWidget(),
          ),
        ],
      );

  static Component get containerStory => Component(
        componentName: 'TextField',
        states: [
          ComponentState.child(
            stateName: 'Widget',
            child: Container(),
          ),
        ],
      );
}
