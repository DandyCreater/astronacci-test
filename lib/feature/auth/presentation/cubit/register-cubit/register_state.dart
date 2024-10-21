part of 'register_cubit.dart';

class RegistState extends Equatable {
  String? firstName;
  String? lastName;
  String? bornPlace;
  String? bornDate;
  String? gender = "Male";
  String? address;
  String? email;
  String? password;
  RegistState({
    this.firstName,
    this.lastName,
    this.bornPlace,
    this.bornDate,
    this.gender,
    this.address,
    this.email,
    this.password,
  });

  RegistState copyWith({
    String? firstName,
    String? lastName,
    String? bornPlace,
    String? bornDate,
    String? gender,
    String? address,
    String? email,
    String? password,
  }) =>
      RegistState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        bornPlace: bornPlace ?? this.bornPlace,
        bornDate: bornDate ?? this.bornDate,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        firstName,
        lastName,
        gender,
        bornPlace,
        bornDate,
        address,
        email,
        password,
      ];
}
