class RegisterResponse {
  RegisterResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  bool? status;
  String? message;
  RegisterData? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : RegisterData.fromJson(json["data"]),
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
        "data": data == null ? null : data?.toJson(),
        "meta": meta == null ? null : List<dynamic>.from(meta!.map((x) => x)),
        "pagination": pagination == null
            ? null
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class RegisterData {
  RegisterData({
    this.user,
    this.token,
  });

  RegisterUser? user;
  String? token;

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        user: json["user"] == null ? null : RegisterUser.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "token": token,
      };
}

class RegisterUser {
  RegisterUser(
      {this.fullName,
      this.username,
      this.email,
      this.country,
      this.id,
      this.password,
      this.device});

  String? fullName;
  String? username;
  String? email;
  String? country;
  String? id;
  String? password;
  String? device;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        country: json["country"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "username": username,
        "email": email,
        "country": country,
        "id": id,
        "password": password,
        "device_name": device
      };
}
