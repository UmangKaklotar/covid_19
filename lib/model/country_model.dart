// To parse this JSON data, do
//
//     final allCountry = allCountryFromJson(jsonString);

import 'dart:convert';

AllCountry allCountryFromJson(String str) => AllCountry.fromJson(json.decode(str));

String allCountryToJson(AllCountry data) => json.encode(data.toJson());

class AllCountry {
  AllCountry({
    this.id,
    this.message,
    this.global,
    this.countries,
    this.date,
  });

  String? id;
  String? message;
  Global? global;
  List<Cs>? countries;
  DateTime? date;

  factory AllCountry.fromJson(Map<String, dynamic> json) => AllCountry(
    id: json["ID"],
    message: json["Message"],
    global: json["Global"] == null ? null : Global.fromJson(json["Global"]),
    countries: json["Countries"] == null ? [] : List<Cs>.from(json["Countries"]!.map((x) => Cs.fromJson(x))),
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Message": message,
    "Global": global?.toJson(),
    "Countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
    "Date": date?.toIso8601String(),
  };
}

class Cs {
  Cs({
    this.id,
    this.country,
    this.countryCode,
    this.slug,
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
    this.premium,
  });

  String? id;
  String? country;
  String? countryCode;
  String? slug;
  int? newConfirmed;
  int? totalConfirmed;
  int? newDeaths;
  int? totalDeaths;
  int? newRecovered;
  int? totalRecovered;
  DateTime? date;
  Premium? premium;

  factory Cs.fromJson(Map<String, dynamic> json) => Cs(
    id: json["ID"],
    country: json["Country"],
    countryCode: json["CountryCode"],
    slug: json["Slug"],
    newConfirmed: json["NewConfirmed"],
    totalConfirmed: json["TotalConfirmed"],
    newDeaths: json["NewDeaths"],
    totalDeaths: json["TotalDeaths"],
    newRecovered: json["NewRecovered"],
    totalRecovered: json["TotalRecovered"],
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
    premium: json["Premium"] == null ? null : Premium.fromJson(json["Premium"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Country": country,
    "CountryCode": countryCode,
    "Slug": slug,
    "NewConfirmed": newConfirmed,
    "TotalConfirmed": totalConfirmed,
    "NewDeaths": newDeaths,
    "TotalDeaths": totalDeaths,
    "NewRecovered": newRecovered,
    "TotalRecovered": totalRecovered,
    "Date": date?.toIso8601String(),
    "Premium": premium?.toJson(),
  };
}

class Premium {
  Premium();

  factory Premium.fromJson(Map<String, dynamic> json) => Premium(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Global {
  Global({
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
  });

  int? newConfirmed;
  int? totalConfirmed;
  int? newDeaths;
  int? totalDeaths;
  int? newRecovered;
  int? totalRecovered;
  DateTime? date;

  factory Global.fromJson(Map<String, dynamic> json) => Global(
    newConfirmed: json["NewConfirmed"],
    totalConfirmed: json["TotalConfirmed"],
    newDeaths: json["NewDeaths"],
    totalDeaths: json["TotalDeaths"],
    newRecovered: json["NewRecovered"],
    totalRecovered: json["TotalRecovered"],
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "NewConfirmed": newConfirmed,
    "TotalConfirmed": totalConfirmed,
    "NewDeaths": newDeaths,
    "TotalDeaths": totalDeaths,
    "NewRecovered": newRecovered,
    "TotalRecovered": totalRecovered,
    "Date": date?.toIso8601String(),
  };
}