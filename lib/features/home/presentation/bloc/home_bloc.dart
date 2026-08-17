import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:clean_arc_flutter/core/use_case/use_case.dart';
import 'package:clean_arc_flutter/features/home/domain/entities/notes_entity.dart';
import 'package:clean_arc_flutter/features/home/domain/usecases/load_data.dart';
import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadData _loadData;

  HomeBloc(this._loadData) :super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    // Event handlers register
    on<LoadHomeItemsEvent>(_onLoadHomeItems);
    // on<RefreshHomeItemsEvent>(_onRefreshHomeItems);
  }

  Future<void> _onLoadHomeItems(LoadHomeItemsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final items = await _loadData.call(NoParams());
      items.fold((error){
        emit(HomeError(error.toString()));
      },(data){
        emit(HomeSuccess(data));
      });

    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  // Future<void> _onRefreshHomeItems(
  //     RefreshHomeItemsEvent event, Emitter<HomeState> emit) async {
  //   try {
  //     final items = await _homeRepository.getHomeItems();
  //     emit(HomeSuccess(items));
  //   } catch (e) {
  //     // Keep showing previous data on refresh failure
  //   }
  // }
}


