part of 'update_profile_bloc.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final LoginRespEntity data;
  const UpdateProfileSuccess(this.data);
  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class UpdateProfileFailed extends UpdateProfileState {
  final String? msg;

  const UpdateProfileFailed(this.msg);

  @override
  // TODO: implement props
  List<Object> get props => [msg!];
}
