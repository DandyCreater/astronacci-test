import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ObsecureCubit extends Cubit<bool> {
  ObsecureCubit() : super(true);

  void setObsecure(bool obsecure) => emit(obsecure);
}
