part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordFailed extends ResetPasswordState {
  final String? msg;

  const ResetPasswordFailed(this.msg);

  @override
  // TODO: implement props
  List<Object> get props => [msg!];
}
