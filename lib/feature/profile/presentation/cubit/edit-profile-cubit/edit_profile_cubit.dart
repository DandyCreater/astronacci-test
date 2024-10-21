import 'dart:math';

import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState());

  void loadDataFirst(LoginRespEntity data) {
    emit(state.copyWith(uid: data.uid ?? ""));
    emit(state.copyWith(firstName: data.firstName ?? ""));
    emit(state.copyWith(lastName: data.lastName ?? ""));
    emit(state.copyWith(gender: data.gender ?? ""));
    emit(state.copyWith(address: data.address ?? ""));
    emit(state.copyWith(bornPlace: data.bornPlace ?? ""));
    emit(state.copyWith(bornDate: data.bornDate ?? ""));
    emit(state.copyWith(email: data.email ?? ""));
    emit(state.copyWith(imageUrl: data.imageUrl ?? ""));
  }

  void addFirstName(String firstName) =>
      emit(state.copyWith(firstName: firstName));
  void addLastName(String lastName) => emit(state.copyWith(
        lastName: lastName,
      ));
  void addBornPlace(String bornPlace) => emit(state.copyWith(
        bornPlace: bornPlace,
      ));
  void addBornDate(String bornDate) => emit(state.copyWith(
        bornDate: bornDate,
      ));
  void addGender(String gender) => emit(state.copyWith(
        gender: gender,
      ));
  void addAddress(String address) => emit(state.copyWith(
        address: address,
      ));
  void addImage(String imageUrl) => emit(state.copyWith(
        imageUrl: imageUrl,
      ));
}
