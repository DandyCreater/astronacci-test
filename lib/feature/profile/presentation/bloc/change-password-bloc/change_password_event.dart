part of 'change_password_bloc.dart';

class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class StartChangePass extends ChangePasswordEvent {
  final String? oldPassword;
  final String? newPassword;
  final String? email;

  const StartChangePass(
      {required this.email,
      required this.newPassword,
      required this.oldPassword});

  @override
  // TODO: implement props
  List<Object> get props => [oldPassword!, newPassword!];
}
