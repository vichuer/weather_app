// To parse this JSON data, do
//
//     final locationAutoCompleteModel = locationAutoCompleteModelFromJson(jsonString);

import 'dart:convert';

LocationAutoCompleteModel locationAutoCompleteModelFromJson(String str) =>
    LocationAutoCompleteModel.fromJson(json.decode(str));

String locationAutoCompleteModelToJson(LocationAutoCompleteModel data) =>
    json.encode(data.toJson());

class LocationAutoCompleteModel {
  List<Prediction>? predictions;
  String? status;

  LocationAutoCompleteModel({
    this.predictions,
    this.status,
  });

  factory LocationAutoCompleteModel.fromJson(Map<String, dynamic> json) =>
      LocationAutoCompleteModel(
        predictions: List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "predictions": List<dynamic>.from(predictions!.map((x) => x.toJson())),
        "status": status,
      };
}

class Prediction {
  String? description;
  List<MatchedSubstring>? matchedSubstrings;
  String? placeId;
  String? reference;
  List<String>? types;

  Prediction({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.types,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        description: json["description"],
        matchedSubstrings: List<MatchedSubstring>.from(
            json["matched_substrings"]
                .map((x) => MatchedSubstring.fromJson(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "matched_substrings":
            List<dynamic>.from(matchedSubstrings!.map((x) => x.toJson())),
        "place_id": placeId,
        "reference": reference,
        "types": List<dynamic>.from(types!.map((x) => x)),
      };
}

class MatchedSubstring {
  int? length;
  int? offset;

  MatchedSubstring({
    this.length,
    this.offset,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      MatchedSubstring(
        length: json["length"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "offset": offset,
      };
}
