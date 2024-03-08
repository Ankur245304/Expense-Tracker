import 'package:flutter/material.dart';
import 'package:expense_tracker/home_screen.dart';

var colorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 177, 77, 213));
// var darkColorScheme =
//     ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  void changeScheme(int flag) {
    if (flag == 1) {
      //light theme
      colorScheme = ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 177, 77, 213));
      flag = 0;
    } else if (flag == 0) {
      //dark theme
      colorScheme = ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 5, 99, 125));
      flag = 1;
    }
  }

  runApp(
    MaterialApp(
      // darkTheme: ThemeData.dark().copyWith(
      //   brightness: Brightness.dark,
      //   useMaterial3: true,
      //   colorScheme: darkColorScheme,
      //   cardTheme: const CardTheme().copyWith(
      //     color: darkColorScheme.primary,
      //     margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      //   ),
      //   textTheme: ThemeData().textTheme.copyWith(
      //         titleLarge: TextStyle(
      //             fontWeight: FontWeight.w600,
      //             color: darkColorScheme.onSecondaryContainer,
      //             fontSize: 18),
      //       ),
      // ),
      theme: ThemeData().copyWith(
        backgroundColor: colorScheme.secondaryContainer,
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorScheme.outlineVariant,
          foregroundColor: colorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
            color: colorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onSecondary)),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSecondaryContainer,
                  fontSize: 18),
            ),
        colorScheme: colorScheme,
      ),
      // themeMode: ThemeMode.system,
      home: HomeScreen(changeScreen: changeScheme, main: main),
    ),
  );
}
