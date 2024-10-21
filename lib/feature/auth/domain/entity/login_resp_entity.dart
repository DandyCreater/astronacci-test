class LoginRespEntity {
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

  LoginRespEntity({
    this.uid,
    this.firstName,
    this.lastName,
    this.bornPlace,
    this.bornDate,
    this.gender,
    this.address,
    this.email,
    this.imageUrl,
    this.msg,
  });

  factory LoginRespEntity.fromMap(Map<String, dynamic> data, String uid) {
    return LoginRespEntity(
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
}
