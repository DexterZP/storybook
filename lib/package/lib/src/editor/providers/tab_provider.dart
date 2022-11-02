import 'package:flutter/material.dart';

import '../editor.dart';

class TabProvider extends ChangeNotifier {
  TabProvider();
  FlutterBookTab _tab = FlutterBookTab.canvas;

  FlutterBookTab get tab => _tab;

  setTab(selectedTab) {
    _tab = selectedTab;
    notifyListeners();
  }
}
