import 'package:flutter/material.dart';
import 'package:rambo_news/home.dart';
import 'package:rambo_news/homepage.dart';

const lightGreen = Color(0xff4CAF50);
const darkGreen = Color(0xff388E3C);
const yellow = Color(0xffFFEB3B);

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: darkGreen,
      appBarTheme: AppBarTheme(
        color: darkGreen,
      ),
    ),
    home: HomePage(),
  ),
);




