part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectedState extends ConnectivityState {}

class DisconnectedState extends ConnectivityState {}

class UnknownState extends ConnectivityState {}
