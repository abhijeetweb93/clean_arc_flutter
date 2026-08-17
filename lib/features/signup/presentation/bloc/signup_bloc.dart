import 'package:bloc/bloc.dart';
import 'package:clean_arc_flutter/features/signup/domain/entities/signup_entity.dart';
import 'package:clean_arc_flutter/features/signup/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase signupUseCase;

  SignupBloc({required this.signupUseCase}) : super(SignupInitial()) {
    on<DoSignupEvent>(_onSignupEvent);
  }

  Future<void> _onSignupEvent(DoSignupEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    final signupEntity = SignupEntity(
      username: event.username,
      email: event.email,
      password: event.password,
    );

    final result = await signupUseCase.call(signupEntity);
    result.fold(
      (left) => emit(SignupError(left.toString())),
      (right) => emit(SignupSuccess(right)),
    );
  }
}
