class UserRespEntity {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<DataUserEntity> data;
  SupportEntity support;

  UserRespEntity({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory UserRespEntity.fromJson(Map<String, dynamic> json) => UserRespEntity(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<DataUserEntity>.from(
            json["data"].map((x) => DataUserEntity.fromJson(x))),
        support: SupportEntity.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
      };
}

class DataUserEntity {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  DataUserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory DataUserEntity.fromJson(Map<String, dynamic> json) => DataUserEntity(
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
}

class SupportEntity {
  String url;
  String text;

  SupportEntity({
    required this.url,
    required this.text,
  });

  factory SupportEntity.fromJson(Map<String, dynamic> json) => SupportEntity(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
