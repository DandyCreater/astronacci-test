import 'package:astronacci/feature/auth/data/model/login_resp_model.dart';
import 'package:astronacci/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthUseCase authUseCase;
  RegisterBloc(this.authUseCase) : super(RegisterInitial()) {
    on<StartRegister>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await authUseCase.call(event.parameter);
        result.fold((l) {
          emit(RegisterFailed(msg: l));
        }, (r) {
          emit(RegisterSuccess());
        });
      } catch (e) {
        emit(const RegisterFailed(msg: "Bloc Register Error"));
        debugPrint("Bloc Register Error $e");
      }
    });
  }
}
