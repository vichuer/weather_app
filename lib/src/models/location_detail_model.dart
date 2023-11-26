// To parse this JSON data, do
//
//     final locationDeatailModel = locationDeatailModelFromJson(jsonString);

import 'dart:convert';

LocationDeatailModel locationDeatailModelFromJson(String str) =>
    LocationDeatailModel.fromJson(json.decode(str));

String locationDeatailModelToJson(LocationDeatailModel data) =>
    json.encode(data.toJson());

class LocationDeatailModel {
  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  LocationDeatailModel({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  factory LocationDeatailModel.fromJson(Map<String, dynamic> json) =>
      LocationDeatailModel(
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: Result.fromJson(json["result"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions":
            List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "result": result!.toJson(),
        "status": status,
      };
}

class Result {
  Geometry? geometry;
  String? placeId;
  String? reference;
  List<String>? types;
  String? website;

  Result({
    this.geometry,
    this.placeId,
    this.reference,
    this.types,
    this.website,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        geometry: Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"],
        reference: json["reference"],
        types: List<String>.from(json["types"].map((x) => x)),
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry!.toJson(),
        "place_id": placeId,
        "reference": reference,
        "types": List<dynamic>.from(types!.map((x) => x)),
        "website": website,
      };
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location!.toJson(),
        "viewport": viewport!.toJson(),
      };
}

class Location {
  double? lat;
  double? lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast!.toJson(),
        "southwest": southwest!.toJson(),
      };
}
