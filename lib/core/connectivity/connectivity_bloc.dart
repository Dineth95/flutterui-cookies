import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(UnknownState()) {
    final Connectivity connectivity = Connectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        add(DisconnectConnectivityEvent());
      } else {
        add(ConnectedConnectivityEvent());
      }
    });

    checkConnection(connectivity: connectivity);
  }

  StreamSubscription connectivitySubscription;
  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is ConnectedConnectivityEvent) {
      yield ConnectedState();
    } else if (event is DisconnectConnectivityEvent) {
      yield DisconnectedState();
    } else {
      yield UnknownState();
    }
  }

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }

  Future<void> checkConnection({@required Connectivity connectivity}) async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      add(ConnectedConnectivityEvent());
    } else {
      add(ConnectedConnectivityEvent());
    }
  }
}
