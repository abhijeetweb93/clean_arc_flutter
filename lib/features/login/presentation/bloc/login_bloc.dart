import 'package:bloc/bloc.dart';
import 'package:clean_arc_flutter/core/use_case/use_case.dart';
import 'package:clean_arc_flutter/features/login/domain/usecases/login_usecase.dart';
import 'package:clean_arc_flutter/features/login/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/login_entity.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;
  LogoutUseCase logoutUseCase;


  LoginBloc({required this.loginUseCase, required this.logoutUseCase}) :super(LoginInitial()) {
    // on<LoginEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<DoLoginEvent>(_onLoginEvent);
    on<DoLogOutEvent>(_onLogOut);
  }

  Future<void> _onLoginEvent(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    var user = await loginUseCase.call((event.email, event.password));
    user.fold((left) {
      emit(LoginError(left.toString()));
    }, (right) {
      emit(LoginSuccess(right));
    });
  }

  Future<void> _onLogOut(DoLogOutEvent event, Emitter<LoginState> emit) async{
    emit(LoginLoading());
    var result = await logoutUseCase.call(NoParams());
    result.fold((fail){},(data){
      emit(const LogoutSuccess());
    });
  }

  @override
  Future<void> close() {
    // Dispose Controllers
    return super.close();
  }
}