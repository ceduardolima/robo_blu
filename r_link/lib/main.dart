import 'package:flutter/material.dart';
import 'package:r_link/ui/pages/main_page.dart';
import 'package:r_link/resources/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
