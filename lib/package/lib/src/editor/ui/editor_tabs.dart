import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook/package/lib/src/editor/providers/tab_provider.dart';

import '../../utils/extensions.dart';

enum FlutterBookTab { canvas, cod, doc }

class CoreContentTabs extends StatefulWidget {
  const CoreContentTabs({super.key});

  @override
  CoreContentTabsState createState() => CoreContentTabsState();
}

class CoreContentTabsState extends State<CoreContentTabs> {
  @override
  Widget build(BuildContext context) {
    final TextStyle selectedTabStyle = context.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.orange,
    );

    final TextStyle tabStyle = context.textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.bold,
      color: context.theme.hintColor,
    );

    return IntrinsicHeight(
      child: Row(
        children: [
          TextButton(
            onPressed: () => Provider.of<TabProvider>(
              context,
              listen: false,
            ).setTab(FlutterBookTab.canvas),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange,
                    style: context.watch<TabProvider>().tab ==
                            FlutterBookTab.canvas
                        ? BorderStyle.solid
                        : BorderStyle.none,
                    width: 3,
                  ),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text(
                'Visualização',
                style: context.read<TabProvider>().tab == FlutterBookTab.canvas
                    ? selectedTabStyle
                    : tabStyle,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Provider.of<TabProvider>(
              context,
              listen: false,
            ).setTab(FlutterBookTab.cod),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange,
                    style:
                        context.watch<TabProvider>().tab == FlutterBookTab.cod
                            ? BorderStyle.solid
                            : BorderStyle.none,
                    width: 3,
                  ),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text(
                'Código',
                style: context.read<TabProvider>().tab == FlutterBookTab.cod
                    ? selectedTabStyle
                    : tabStyle,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Provider.of<TabProvider>(
              context,
              listen: false,
            ).setTab(FlutterBookTab.doc),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange,
                    style:
                        context.watch<TabProvider>().tab == FlutterBookTab.doc
                            ? BorderStyle.solid
                            : BorderStyle.none,
                    width: 3,
                  ),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Text(
                'Documentação',
                style: context.read<TabProvider>().tab == FlutterBookTab.doc
                    ? selectedTabStyle
                    : tabStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
