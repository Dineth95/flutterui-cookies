part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectedConnectivityEvent extends ConnectivityEvent {}

class DisconnectConnectivityEvent extends ConnectivityEvent {}

