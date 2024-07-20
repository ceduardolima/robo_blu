import 'package:flutter/material.dart';

class GlobalVariables {
  static final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static ScaffoldMessengerState getScaffoldState() {
    return rootScaffoldMessengerKey.currentState!;
  }
}
