// main.dart
// This is the starting point of the Flutter application.
// The app starts from this file when the user runs the project.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/app_provider.dart';

void main() {
  runApp(
    // ChangeNotifierProvider is used to provide AppProvider to the whole app.
    // This allows all screens to access and update shared data such as events,
    // booths, applications, and user role.
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const ExhibitionApp(),
    ),
  );
}