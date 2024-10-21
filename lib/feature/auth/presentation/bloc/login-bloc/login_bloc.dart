import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';
import 'package:astronacci/feature/auth/domain/usecase/login_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<StartLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final result =
            await loginUseCase.call(event.email ?? "", event.password ?? "");
        result.fold((l) {
          emit(LoginFailed(msg: l));
        }, (r) {
          emit(LoginSuccess(data: r));
        });
      } catch (e) {
        emit(LoginFailed(msg: "Login Bloc Error $e"));
        debugPrint("Login Bloc Error $e");
      }
    });
  }
}
