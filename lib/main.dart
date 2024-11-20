import 'package:bhagavad_gita/provider/theme_provider.dart';
import 'package:bhagavad_gita/screens/detail_screen.dart';
import 'package:bhagavad_gita/screens/home_screen.dart';
import 'package:bhagavad_gita/screens/splash_screen.dart';
import 'package:bhagavad_gita/screens/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'SplashScreen',

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.getThemeMode() == ThemeMode.system
          ? ThemeMode.system
          : themeProvider.getThemeMode(),
      routes: {
        '/': (context) => HomeScreen(),
        'DetailScreen': (context) => DetailScreen(),
        'SplashScreen': (context) => SplashScreen(),
      },
    );
  }
}