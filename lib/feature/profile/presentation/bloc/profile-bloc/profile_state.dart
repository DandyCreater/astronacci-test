part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final LoginRespEntity data;

  const ProfileSuccess(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class ProfileFailed extends ProfileState {
  final String? msg;

  const ProfileFailed(this.msg);
}
