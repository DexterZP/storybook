import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook/package/lib/flutterbook.dart';
import 'package:storybook/package/lib/src/editor/providers/device_preview_provider.dart';
import 'package:storybook/package/lib/src/editor/providers/tab_provider.dart';

import 'editor/editor.dart';
import 'navigation/navigation.dart';
import 'routing/router.dart';
import 'styled_widgets/styled_widgets.dart';
import 'utils/utils.dart';

class FlutterBook extends StatefulWidget {
  final List<Category> categories;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final Widget? header;
  final EdgeInsetsGeometry headerPadding;
  final List<FlutterBookTheme>? themes;

  const FlutterBook({
    Key? key,
    required this.categories,
    this.theme,
    this.darkTheme,
    this.header,
    this.headerPadding = const EdgeInsets.fromLTRB(20, 16, 20, 8),
    this.themes,
  }) : super(key: key);

  @override
  FlutterBookState createState() => FlutterBookState();
}

class FlutterBookState extends State<FlutterBook> {
  GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
  Widget? selectedComponent;

  bool get useMultiTheme => widget.themes != null && widget.themes!.length > 1;
  List<String> get themeNames =>
      widget.themes?.map((theme) => theme.themeName).toList() ?? [];

  @override
  void initState() {
    if (widget.darkTheme != null) Styles.darkTheme = widget.darkTheme!;
    if (widget.theme != null) Styles.lightTheme = widget.theme!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget.categories),
        ChangeNotifierProvider(create: (_) => CanvasDelegateProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(
            useListOfThemes: useMultiTheme,
            themeNames: themeNames,
          ),
        ),
        ChangeNotifierProvider(create: (_) => DevicePreviewProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, model, Widget? child) {
          ThemeData activeTheme = useMultiTheme
              ? widget.themes![model.activeThemeIndex].theme
              : widget.theme ?? Styles().theme;

          return MaterialApp(
            title: 'Flutterbook',
            debugShowCheckedModeBanner: false,
            theme: activeTheme,
            builder: (context, child) {
              return StyledScaffold(
                body: Row(
                  children: [
                    NavigationPanel(
                      header: widget.header,
                      headerPadding: widget.headerPadding,
                      categories: context.watch<List<Category>>().toList(),
                      onComponentSelected: (child) {
                        navigator.currentState!.pushReplacementNamed(
                            '/stories/${child?.path ?? ''}');
                        context
                            .read<CanvasDelegateProvider>()
                            .storyProvider!
                            .updateStory(child);
                      },
                    ),
                    Expanded(
                      child: Navigator(
                        reportsRouteUpdateToEngine: true,
                        key: navigator,
                        initialRoute: '/',
                        onGenerateRoute: (settings) => generateRoute(
                          context,
                          settings.name,
                          settings: settings,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
