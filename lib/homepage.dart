import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rambo_news/pages/bitcoinnews.dart';
import 'package:rambo_news/pages/nigeriannews.dart';
import 'package:rambo_news/pages/stocks.dart';

const lightGreen = Color(0xff4CAF50);
const darkGreen = Color(0xff388E3C);
const yellow = Color(0xffFFEB3B);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void gotoBitcoinNewsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => BitcoinNews()));
  }

  void gotoNigerianNewsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NigerianNews()));
  }

  void gotoStockNewsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StockNews()));
  }

  Expanded MenuCard({SvgPicture icon, String label, int l, int t, int r, int b, Function function}){
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
              color: darkGreen,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
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
                        child: Text(
                          'Rambo News',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ),
                    Expanded(
                      flex: 6,
                      child: Image.asset('images/art.png', scale: 1,),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
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
                                label: 'Top\nHeadlines',
                                l: 34,
                                t: 22,
                                r: 11,
                                b: 0,

                              ),
                              MenuCard(
                                icon: SvgPicture.asset('images/nigeria.svg'),
                                label: 'Nigerian\nNews',
                                l: 11,
                                t: 22,
                                r: 34,
                                b: 0,
                                function: gotoNigerianNewsPage,
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
                              ),
                              MenuCard(
                                icon: SvgPicture.asset('images/bitcoin.svg'),
                                label: 'Bitcoin',
                                l: 11,
                                t: 22,
                                r: 34,
                                b: 0,
                                function: gotoBitcoinNewsPage,
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
