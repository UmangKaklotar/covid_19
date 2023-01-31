import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.poppins(),
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    ),
  );
}