import 'package:bhagavad_gita/screens/detail_screen.dart';
import 'package:bhagavad_gita/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const HomeScreen(),
      'DetailScreen': (context) => const DetailScreen(),
    },
  ));
}