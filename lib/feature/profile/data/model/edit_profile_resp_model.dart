import 'dart:io';

class EditProfileParameterPost {
  String? uid;
  String? firstName;
  String? lastName;
  String? bornPlace;
  String? bornDate;
  String? gender;
  String? address;
  String? imageUrl;
  File fileData;

  EditProfileParameterPost({
    required this.uid,
    required this.address,
    required this.bornDate,
    required this.bornPlace,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.imageUrl,
    required this.fileData,
  });
}
