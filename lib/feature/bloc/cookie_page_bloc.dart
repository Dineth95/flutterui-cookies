import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercookie/core/connectivity/connectivity_bloc.dart';
import 'package:fluttercookie/feature/model/cookie_model.dart';

part 'cookie_page_event.dart';
part 'cookie_page_state.dart';

class CookiePageBloc extends Bloc<CookiePageEvent, CookiePageState> {
  CookiePageBloc({@required this.connectivityBloc})
      : super(CookiePageInitialState()) {
    ///start listening to the connectivity bloc
    listenToConnectivityBloc();
    add(CookiePageRequestedEvent());
  }

  final ConnectivityBloc connectivityBloc;
  StreamSubscription connectivitySubscription;

  @override
  Stream<CookiePageState> mapEventToState(CookiePageEvent event) async* {
    if (event is CookiePageRequestedEvent) {
      yield CookiePageLoadingState();
      yield* _mapCookiePageEventToState();
    } else if (event is InternetConnectionFailedEvent) {
      yield InternetConnectionFailedState();
    } else {
      yield CookiePageLoadingFailedState();
    }
  }

  Stream<CookiePageState> _mapCookiePageEventToState() async* {
    Future.delayed(Duration(milliseconds: 1000), () {});
    List<Cookie> cookieList = List<Cookie>();
    cookieList.add(Cookie(
        name: 'Cookie mint',
        price: '\$3.99',
        imgPath: 'assets/cookiemint.jpg',
        isFavourite: false,
        added: false));

    cookieList.add(Cookie(
        name: 'Cookie cream',
        price: '\$5.99',
        imgPath: 'assets/cookiecream.jpg',
        isFavourite: false,
        added: true));

    cookieList.add(Cookie(
        name: 'Cookie classic',
        price: '\$1.99',
        imgPath: 'assets/cookieclassic.jpg',
        isFavourite: true,
        added: false));

    cookieList.add(Cookie(
        name: 'Cookie choco',
        price: '\$2.99',
        imgPath: 'assets/cookiechoco.jpg',
        isFavourite: false,
        added: false));

    yield CookiePageloadedState(cookieList: cookieList);
  }

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }

  void listenToConnectivityBloc() {
    if (connectivitySubscription == null) {
      connectivitySubscription = connectivityBloc.listen((state) {
        if (state is DisconnectedState) {
          add(InternetConnectionFailedEvent());
        } else {
          add(CookiePageRequestedEvent());
        }
      });
    }
  }
}
