import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class StorybookManager extends StatefulWidget {
  final String title;
  final Widget child;
  final String lib;
  final String? url;

  const StorybookManager({
    super.key,
    required this.title,
    required this.child,
    required this.lib,
    this.url,
  });

  @override
  State<StorybookManager> createState() => _StorybookManagerState();
}

class _StorybookManagerState extends State<StorybookManager> {
  final controller = PageController();

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        scrollBehavior: ScrollBehavior(),
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              const Divider(),
              Container(
                color: Colors.grey[200],
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    var titles = [
                      "Visualização",
                      "Código",
                      "Documentação",
                    ];

                    return InkWell(
                      onTap: () => setState(() {
                        _selected = index;
                        controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.decelerate,
                        );
                      }),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            titles[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _selected == index
                                  ? Colors.black87
                                  : Colors.grey,
                            ),
                          ),
                          Visibility(
                            visible: _selected == index,
                            replacement: const SizedBox(
                              width: 100,
                              height: 2,
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 100,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    widget.child,
                    SourceCodeView(filePath: widget.lib),
                    WebViewX(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      initialContent:
                          'https://doc.clickup.com/3084385/p/h/2y431-52263/b70168854abd3c4',
                      initialSourceType: SourceType.url,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
