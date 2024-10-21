part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class StartRegister extends RegisterEvent {
  final RegisterParameterPost parameter;

  const StartRegister({required this.parameter});

  @override
  // TODO: implement props
  List<Object> get props => [parameter];
}
