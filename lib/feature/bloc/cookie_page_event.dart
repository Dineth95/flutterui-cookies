part of 'cookie_page_bloc.dart';

abstract class CookiePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CookiePageRequestedEvent extends CookiePageEvent {}

class InternetConnectionFailedEvent extends CookiePageEvent {}

