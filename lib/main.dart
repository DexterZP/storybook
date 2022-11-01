import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/storybook.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Storybook',
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: StoryBook(),
    );
  }
}

class ScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
