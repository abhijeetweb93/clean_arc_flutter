part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {}

class LoadHomeItemsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class RefreshHomeItemsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}