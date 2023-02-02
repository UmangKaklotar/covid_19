import 'dart:convert';

import 'package:http/http.dart';

import '../model/country_model.dart';
import '../utils/api_string.dart';

Future getCountryResponse() async {
  Response res = await get(Uri.parse(ApiUtils.COUNTRY_BASE_URL));
  print(res.statusCode);
  if(res.statusCode == 200) {
    AllCountry allCountry = AllCountry.fromJson(jsonDecode(res.body));
    return allCountry.countries;
  } else {
    throw "No Data Found";
  }
}