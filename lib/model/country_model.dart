// To parse this JSON data, do
//
//     final allCountry = allCountryFromJson(jsonString);

import 'dart:convert';

List<AllCountry> allCountryFromJson(String str) => List<AllCountry>.from(json.decode(str).map((x) => AllCountry.fromJson(x)));

String allCountryToJson(List<AllCountry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCountry {
  AllCountry({
    this.country,
    this.slug,
    this.iso2,
  });

  String? country;
  String? slug;
  String? iso2;

  factory AllCountry.fromJson(Map<String, dynamic> json) => AllCountry(
    country: json["Country"],
    slug: json["Slug"],
    iso2: json["ISO2"],
  );

  Map<String, dynamic> toJson() => {
    "Country": country,
    "Slug": slug,
    "ISO2": iso2,
  };
}
