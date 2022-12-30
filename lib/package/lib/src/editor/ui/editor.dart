import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook/package/lib/src/editor/providers/tab_provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

import '../../../flutterbook.dart';
import '../../routing/story_provider.dart';
import '../../utils/utils.dart';
import '../providers/canvas_delegate.dart';
import 'editor_tabs.dart' as editor;

class Editor extends StatelessWidget {
  const Editor({
    super.key,
    required this.component,
  });

  final Widget? component;

  @override
  Widget build(BuildContext context) {
    ComponentState? currentStory =
        context.watch<CanvasDelegateProvider>().storyProvider?.currentStory;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: context.theme.shadowColor.withOpacity(0.075),
          ),
        ],
        borderRadius: canvasBorderRadius,
        color: context.colorScheme.surface,
      ),
      margin: const EdgeInsets.fromLTRB(0, 12, 12, 12),
      child: ClipRRect(
        borderRadius: canvasBorderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: editor.CoreContentTabs(),
            ),
            Divider(
              height: 0,
              color: context.theme.dividerColor.withOpacity(0.5),
            ),
            // Canvas
            Expanded(
              child: Consumer<TabProvider>(
                builder: (context, model, child) {
                  late Widget element;

                  if (model.tab == editor.FlutterBookTab.canvas) {
                    element = _Canvas(component);
                  } else if (model.tab == editor.FlutterBookTab.cod) {
                    element = _Doc(currentStory);
                  } else {
                    element = _DocWeb(currentStory);
                  }

                  return element;
                },
              ),
            ),
            Divider(
              height: 0,
              color: context.theme.dividerColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _Canvas extends StatelessWidget {
  final Widget? component;
  const _Canvas(this.component);

  @override
  Widget build(BuildContext context) {
    return _DevicePreviewCanvas(component);
  }
}

class _DevicePreviewCanvas extends StatelessWidget {
  final Widget? component;
  const _DevicePreviewCanvas(
    this.component,
  );
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      isToolbarVisible: true,
      builder: (context) {
        return component ?? Container();
      },
    );
  }
}

class _Doc extends StatelessWidget {
  final ComponentState? component;

  const _Doc(this.component);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) => SizedBox(
        height: constrains.maxHeight,
        child: component != null && component!.codeSample != null
            ? WidgetWithCodeView(
                filePath: component!.codeSample!,
                labelBackgroundColor: Colors.white,
              )
            : const Center(
                child: Text("Nenhum código implementado"),
              ),
      ),
    );
  }
}

class _DocWeb extends StatelessWidget {
  final ComponentState? component;

  const _DocWeb(this.component);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) => SizedBox(
        height: constrains.maxHeight,
        child: component?.docWeb != null
            ? WebViewX(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                initialContent: component!.docWeb!,
                initialSourceType: SourceType.url,
              )
            : const Center(
                child: Text("Nenhuma documentação web implementada"),
              ),
      ),
    );
  }
}

class Story extends StatelessWidget {
  const Story({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final story = context.watch<StoryProvider>().currentStory;

    return story?.builder(
            context, context.watch<CanvasDelegateProvider>().storyProvider!) ??
        Container(
          color: context.colorScheme.onSecondary,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('😉', style: context.textTheme.headline2),
                const SizedBox(height: 12),
                const Text(
                  'Selecione um storie!',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
