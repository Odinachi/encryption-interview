class HomeResponse {
  HomeResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  bool? status;
  String? message;
  HomeData? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
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

class HomeData {
  HomeData({
    this.secret,
  });

  String? secret;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "secret": secret,
      };
}
