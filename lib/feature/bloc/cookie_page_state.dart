part of 'cookie_page_bloc.dart';

abstract class CookiePageState extends Equatable {
  @override
  List<Object> get props => [];
}

class CookiePageInitialState extends CookiePageState {}

class CookiePageLoadingState extends CookiePageState {}

class CookiePageloadedState extends CookiePageState {}

class CookiePageLoadingFailedState extends CookiePageState {}

class InternetConnectionFailedState extends CookiePageState {}


