import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegistState> {
  RegisterCubit() : super(RegistState());

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
  void addEmail(String email) => emit(state.copyWith(
        email: email,
      ));
  void addPassword(String password) => emit(state.copyWith(
        password: password,
      ));
}
