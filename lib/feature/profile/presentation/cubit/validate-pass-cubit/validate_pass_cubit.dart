import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ValidatePassCubit extends Cubit<bool> {
  ValidatePassCubit() : super(true);
  void setValidatePass(bool isActive) => emit(isActive);
}
