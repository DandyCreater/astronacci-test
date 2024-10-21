import 'package:astronacci/feature/dashboard/domain/entity/user_resp_entity.dart';

class UserRespModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<DataUser> data;
  Support support;

  UserRespModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory UserRespModel.fromJson(Map<String, dynamic> json) => UserRespModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data:
            List<DataUser>.from(json["data"].map((x) => DataUser.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
      };

  UserRespEntity toEntity() {
    return UserRespEntity(
        page: page,
        perPage: perPage,
        total: total,
        totalPages: totalPages,
        data: data.map((e) => e.toEntity()).toList(),
        support: support.toEntity());
  }
}

class DataUser {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  DataUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };

  DataUserEntity toEntity() {
    return DataUserEntity(
        id: id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        avatar: avatar);
  }
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
  SupportEntity toEntity() {
    return SupportEntity(url: url, text: text);
  }
}

class UserDetail {
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;

  const UserDetail(
      {required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.email});
}
