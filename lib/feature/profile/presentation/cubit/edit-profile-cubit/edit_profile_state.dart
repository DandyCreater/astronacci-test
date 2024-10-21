part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  String? uid;
  String? firstName;
  String? lastName;
  String? bornPlace;
  String? bornDate;
  String? gender;
  String? address;
  String? email;
  String? password;
  String? imageUrl;
  EditProfileState({
    this.uid,
    this.firstName,
    this.lastName,
    this.bornDate,
    this.bornPlace,
    this.address,
    this.email,
    this.gender,
    this.password,
    this.imageUrl,
  });

  EditProfileState copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? bornPlace,
    String? bornDate,
    String? gender,
    String? address,
    String? email,
    String? imageUrl,
  }) =>
      EditProfileState(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        bornDate: bornDate ?? this.bornDate,
        bornPlace: bornPlace ?? this.bornPlace,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        uid,
        firstName,
        lastName,
        bornPlace,
        bornDate,
        gender,
        email,
        imageUrl,
        address,
      ];
}
