import 'package:astronacci/feature/auth/domain/entity/login_resp_entity.dart';

class LoginRespModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? bornPlace;
  String? bornDate;
  String? gender;
  String? address;
  String? email;
  String? imageUrl;
  String? msg;

  LoginRespModel({
    this.firstName,
    this.lastName,
    this.bornPlace,
    this.bornDate,
    this.gender,
    this.address,
    this.email,
    this.imageUrl,
    this.msg,
    this.uid,
  });

  factory LoginRespModel.fromMap(Map<String, dynamic> data, String uid) {
    return LoginRespModel(
      uid: uid,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      bornPlace: data['bornPlace'] ?? '',
      bornDate: data['bornDate'] ?? '',
      gender: data['gender'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'bornPlace': bornPlace,
      'bornDate': bornDate,
      'gender': gender,
      'address': address,
      'email': email,
    };
  }

  LoginRespEntity toEntity() {
    return LoginRespEntity(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        bornPlace: bornPlace,
        bornDate: bornDate,
        gender: gender,
        address: address,
        email: email,
        imageUrl: imageUrl,
        msg: msg);
  }
}

class RegisterParameterPost {
  final String? firstName;
  final String? lastName;
  final String? bornPlace;
  final String? bornDate;
  final String? gender;
  final String? address;
  final String? email;
  final String? password;

  const RegisterParameterPost({
    required this.firstName,
    required this.address,
    required this.bornDate,
    required this.bornPlace,
    required this.gender,
    required this.lastName,
    required this.password,
    required this.email,
  });
}
