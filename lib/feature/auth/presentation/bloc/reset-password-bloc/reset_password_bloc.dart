import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecase/reset_pass_usecase.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPassUseCase resetPassUseCase;
  ResetPasswordBloc(this.resetPassUseCase) : super(ResetPasswordInitial()) {
    on<StartResetPass>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        final result = await resetPassUseCase.call(event.email);
        result.fold((l) {
          emit(ResetPasswordFailed(l));
        }, (r) {
          emit(ResetPasswordSuccess());
        });
      } catch (e) {
        debugPrint("Reset Password Bloc Error $e");
        emit(const ResetPasswordFailed("Reset Password Error !"));
      }
    });
  }
}
