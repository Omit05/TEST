// app.dart
// This file controls the main app configuration such as theme,
// app title, and the first page that will be shown to the user.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/guest_home_page.dart';

class ExhibitionApp extends StatelessWidget {
  const ExhibitionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner on the top right side of the app.
      debugShowCheckedModeBanner: false,

      title: 'Exhibition Booth App',

      // ThemeData is used to set the app design style.
      // This app uses Material 3 design and indigo as the main colour.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),

      // GuestHomePage is the first screen shown when the app starts.
      home: const GuestHomePage(),
    );
  }
}