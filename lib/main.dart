import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rambo_news/NewHome.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesBloc.dart';
import 'package:rambo_news/home.dart';
import 'package:rambo_news/homepage.dart';

const lightGreen = Color(0xff4CAF50);
const darkGreen = Color(0xff388E3C);
const yellow = Color(0xffFFEB3B);

void main() => runApp(
    BlocProvider<SavedArticlesBloc>(
      create: (BuildContext context) => SavedArticlesBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage()
      ),
    )

);




