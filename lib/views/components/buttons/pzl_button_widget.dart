import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PZLButtonWidget extends StatelessWidget {
  const PZLButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
