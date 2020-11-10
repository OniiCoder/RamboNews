import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesBloc.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesEvent.dart';
import 'package:rambo_news/bloc/savedarticlesbloc/SavedArticlesState.dart';
import 'package:rambo_news/pages/SavedArticlesPage.dart';
import 'package:rambo_news/pages/bitcoinnews.dart';
import 'package:rambo_news/pages/explorepage.dart';
import 'package:rambo_news/pages/nigeriannews.dart';
import 'package:rambo_news/pages/stocks.dart';
import 'package:badges/badges.dart';

const lightGreen = Color(0xff4CAF50);
const darkGreen = Color(0xff388E3C);
const yellow = Color(0xffFFEB3B);

const blueColor = Color(0xff304FFF);
const greyColor = Color(0xffF8F8F8);
const redColor = Color(0xffDB3635);
const purpleColor = Color(0xff6200E9);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SavedArticlesBloc savedArticlesBloc;

  @override
  void initState() {
    savedArticlesBloc = BlocProvider.of<SavedArticlesBloc>(context);
    super.initState();
  }


  void gotoBitcoinNewsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => BitcoinNews()));
  }

  void gotoNigerianNewsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NigerianNews()));
  }

  void gotoStockNewsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StockNews()));
  }

  void gotoExplore() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ExplorePage()));
  }

  Expanded MenuCard({SvgPicture icon, String label, int l, int t, int r, int b, Function function, Color bg}){
    return Expanded(
      flex: 6,
      child: Container(
        margin: EdgeInsets.fromLTRB(l.toDouble(), t.toDouble(), r.toDouble(), b.toDouble()),
        child: GestureDetector(
          onTap: function,
          child: Container(
            height: 176,
            padding: EdgeInsets.all(20),
//            margin: EdgeInsets.fromLTRB(l.toDouble(), t.toDouble(), r.toDouble(), b.toDouble()),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    icon,
                  ],
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('RamboNews'),
        centerTitle: false,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SavedArticlesPage())),
            child: Row(
              children: [
                Text('Saved', style: TextStyle(color: Colors.white),),
                SizedBox(width: 3.0,),
                Badge(
                  badgeContent: BlocConsumer<SavedArticlesBloc, SavedArticlesState>(
                    cubit: savedArticlesBloc,
                    builder: (context, state) {
                      if(state is ArticlesFetched) {
                        return Text(state.articles.length.toString());
                      }

                      return Text(
                        ''
                      );
                    },
                    listener: (context, state){},
                  ),

                  child: Icon(Icons.favorite, color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(34, 0, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Rambo',
                            style: TextStyle(
                              color: blueColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan> [
                              TextSpan(
                                  text: ' News',
                              ),
                            ],
                          ),
                        ),
                      ),

                    ),
                    Expanded(
                      flex: 6,
                      child: Image.asset('images/art2.png', scale: 1,),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              MenuCard(
                                icon: SvgPicture.asset('images/globe.svg'),
                                label: 'Explore',
                                l: 34,
                                t: 22,
                                r: 11,
                                b: 0,
                                bg: Colors.grey[900],
                                function: gotoExplore
                              ),
                              MenuCard(
                                icon: SvgPicture.asset('images/nigeria.svg'),
                                label: 'Nigerian\nNews',
                                l: 11,
                                t: 22,
                                r: 34,
                                b: 0,
                                function: gotoNigerianNewsPage,
                                bg: darkGreen,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              MenuCard(icon: SvgPicture.asset('images/stock.svg'),
                                label: 'Stock\nNews',
                                l: 34,
                                t: 22,
                                r: 11,
                                b: 0,
                                function: gotoStockNewsPage,
                                bg: redColor,
                              ),
                              MenuCard(
                                icon: SvgPicture.asset('images/bitcoin.svg'),
                                label: 'Bitcoin',
                                l: 11,
                                t: 22,
                                r: 34,
                                b: 0,
                                function: gotoBitcoinNewsPage,
                                bg: purpleColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
