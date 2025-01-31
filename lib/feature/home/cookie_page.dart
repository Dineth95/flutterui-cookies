import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercookie/feature/bloc/cookie_page_bloc.dart';
import 'package:fluttercookie/feature/home/cookie_detail.dart';
import 'package:fluttercookie/feature/model/cookie_model.dart';

class CookiePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFCFAF8),
        body: BlocBuilder<CookiePageBloc, CookiePageState>(
            // bloc: context
            //     .read<CookiePageBloc>(), // provide the local bloc instance
            builder: (context, state) {
          if (state is CookiePageLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CookiePageloadedState) {
            return ListView(
              children: <Widget>[
                SizedBox(height: 15.0),
                Container(
                    padding: EdgeInsets.only(right: 15.0),
                    width: MediaQuery.of(context).size.width - 30.0,
                    height: MediaQuery.of(context).size.height - 50.0,
                    child: GridView.count(
                        crossAxisCount: 2,
                        primary: false,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 0.8,
                        children: state.cookieList
                            .map((cookie) => _buildCard(cookie, context))
                            .toList())),
                SizedBox(height: 15.0)
              ],
            );
          } else if (state is InternetConnectionFailedState) {
            print("---------No Internet-------");
            return Center(
              child: AlertDialog(
                title: Text("No Intenet"),
                content: Text("Please check your internet connection"),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {},
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Failed to get data"),
            );
          }
        }));
  }

  Widget _buildCard(Cookie cookie, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CookieDetail(
                      assetPath: cookie.imgPath,
                      cookieprice: cookie.price,
                      cookiename: cookie.name)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            cookie.isFavourite
                                ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                                : Icon(Icons.favorite_border,
                                    color: Color(0xFFEF7532))
                          ])),
                  Hero(
                      tag: cookie.imgPath,
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(cookie.imgPath),
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 7.0),
                  Text(cookie.price,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(cookie.name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: !cookie.added
                              ? [
                                  Icon(Icons.shopping_basket,
                                      color: Color(0xFFD17E50), size: 12.0),
                                  Text('Add to cart',
                                      style: TextStyle(
                                          fontFamily: 'Varela',
                                          color: Color(0xFFD17E50),
                                          fontSize: 12.0))
                                ]
                              : [
                                  Icon(Icons.remove_circle_outline,
                                      color: Color(0xFFD17E50), size: 12.0),
                                  Text('3',
                                      style: TextStyle(
                                          fontFamily: 'Varela',
                                          color: Color(0xFFD17E50),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0)),
                                  Icon(Icons.add_circle_outline,
                                      color: Color(0xFFD17E50), size: 12.0),
                                ]))
                ]))));
  }
}
