import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storybook/views/storybook_manager.dart';

class PZLButtonWidget extends StatefulWidget {
  const PZLButtonWidget({Key? key}) : super(key: key);

  @override
  State<PZLButtonWidget> createState() => _PZLButtonWidgetState();
}

class _PZLButtonWidgetState extends State<PZLButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return StorybookManager(
      title: "PZLButton",
      lib: "lib/views/components/buttons/pzl_button_widget.dart",
      child: Column(
        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: CupertinoButton(
              minSize: 50,
              onPressed: () {},
              color: Colors.red,
              child: const Text(
                "BedFord clicou aqui sem querer e saiu voando",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
