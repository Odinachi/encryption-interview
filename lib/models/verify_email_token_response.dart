class VerifyTokenResponse {
  VerifyTokenResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  bool? status;
  String? message;
  VerifyTokenData? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory VerifyTokenResponse.fromJson(Map<String, dynamic> json) =>
      VerifyTokenResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : VerifyTokenData.fromJson(json["data"]),
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
        "data": data == null ? null : data!.toJson(),
        "meta": meta == null ? null : List<dynamic>.from(meta!.map((x) => x)),
        "pagination": pagination == null
            ? null
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class VerifyTokenData {
  VerifyTokenData({
    this.email,
  });

  String? email;

  factory VerifyTokenData.fromJson(Map<String, dynamic> json) =>
      VerifyTokenData(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
