import 'package:flutter/material.dart';
import 'package:r_link/ui/pages/main_page.dart';
import 'package:r_link/resources/theme/app_theme.dart';
import 'package:r_link/ui/utils/global_variable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: GlobalVariables.rootScaffoldMessengerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        elevatedButtonTheme: buttonThemeData,
        floatingActionButtonTheme: floatingButtonTheme,
        appBarTheme: appBarTheme,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
