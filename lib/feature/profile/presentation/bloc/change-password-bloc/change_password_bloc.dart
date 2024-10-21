import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../auth/domain/usecase/change_pass_usecase.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePassUseCase changePassUseCase;
  ChangePasswordBloc(this.changePassUseCase) : super(ChangePasswordInitial()) {
    on<StartChangePass>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        final result = await changePassUseCase.call(event.email ?? "",
            event.oldPassword ?? "", event.newPassword ?? "");
        result.fold((l) {
          emit(ChangePasswordFailed(l));
        }, (r) {
          emit(ChangePasswordSuccess());
        });
      } catch (e) {
        debugPrint("Change Password Error $e");
        emit(const ChangePasswordFailed("Change Password Error"));
      }
    });
  }
}
