class GetTokenResponse {
  GetTokenResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  bool? status;
  String? message;
  TokenData? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory GetTokenResponse.fromJson(Map<String, dynamic> json) =>
      GetTokenResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : TokenData.fromJson(json["data"]),
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

class TokenData {
  TokenData({
    this.token,
  });

  String? token;

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
