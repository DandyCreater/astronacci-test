import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NewPassCubit extends Cubit<bool> {
  NewPassCubit() : super(true);

  void setNewPass(bool isActive) => emit(isActive);
}
