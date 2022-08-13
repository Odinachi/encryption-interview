class LoginResponse {
  LoginResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  bool? status;
  String? message;
  LoginData? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
        meta: json["meta"] == null
            ? null
            : List<dynamic>.from(json["meta"].map((x) => x)),
        pagination: json["pagination"] == null
            ? null
            : List<dynamic>.from(json["pagination"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "meta": meta == null ? null : List<dynamic>.from(meta!.map((x) => x)),
        "pagination": pagination == null
            ? null
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class LoginData {
  LoginData({
    this.user,
    this.token,
  });

  LoginUser? user;
  String? token;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        user: json["user"] == null ? null : LoginUser.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user?.toJson(),
        "token": token,
      };
}

class LoginUser {
  LoginUser({
    this.id,
    this.fullName,
    this.username,
    this.email,
    this.phone,
    this.phoneCountry,
    this.country,
    this.avatar,
  });

  String? id;
  String? fullName;
  String? username;
  String? email;
  dynamic phone;
  dynamic phoneCountry;
  String? country;
  dynamic avatar;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        phoneCountry: json["phone_country"],
        country: json["country"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "username": username,
        "email": email,
        "phone": phone,
        "phone_country": phoneCountry,
        "country": country,
        "avatar": avatar,
      };
}
