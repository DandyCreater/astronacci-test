import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class OldPassCubit extends Cubit<bool> {
  OldPassCubit() : super(true);

  void setOldPass(bool isActive) => emit(isActive);
}
