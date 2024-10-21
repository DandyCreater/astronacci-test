import 'package:astronacci/feature/profile/data/model/edit_profile_resp_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../auth/domain/entity/login_resp_entity.dart';
import '../../../domain/usecase/profile_usecase.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  ProfileUseCase usecase;

  UpdateProfileBloc(this.usecase) : super(UpdateProfileInitial()) {
    on<StartEditData>((event, emit) async {
      emit(UpdateProfileLoading());
      final result = await usecase.call(event.params);
      result.fold((l) {
        emit(UpdateProfileFailed(l));
      }, (r) {
        emit(UpdateProfileSuccess(r));
      });
    });
  }
}
