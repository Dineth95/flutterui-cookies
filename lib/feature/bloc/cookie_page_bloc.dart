import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cookie_page_event.dart';
part 'cookie_page_state.dart';

class CookiePageBloc extends Bloc<CookiePageEvent, CookiePageState> {
  CookiePageBloc() : super(CookiePageInitialState()) {
    add(CookiePageRequestedEvent());
  }

  StreamSubscription connectivitySubscription;

  @override
  Stream<CookiePageState> mapEventToState(CookiePageEvent event) async* {
    if (event is CookiePageRequestedEvent) {
      yield CookiePageloadedState();
    } else if (event is InternetConnectionFailedEvent) {
      yield InternetConnectionFailedState();
    } else {
      yield CookiePageLoadingFailedState();
    }
  }

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }
}
