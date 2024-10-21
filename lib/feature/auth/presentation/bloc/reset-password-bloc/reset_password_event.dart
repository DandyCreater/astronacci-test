part of 'reset_password_bloc.dart';

class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class StartResetPass extends ResetPasswordEvent {
  final String email;

  const StartResetPass(this.email);

  @override
  // TODO: implement props
  List<Object> get props => [email];
}
