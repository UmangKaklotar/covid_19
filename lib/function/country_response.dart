import 'dart:convert';

import 'package:http/http.dart';

import '../model/country_model.dart';
import '../utils/api_string.dart';

Future getCountryResponse() async {
  Response res = await get(Uri.parse(ApiUtils.COUNTRY_BASE_URL));
  if(res.statusCode == 200) {
    List<dynamic> data = jsonDecode(res.body);
    List country = data.map((e) => Country.fromJson(e)).toList();
    return country;
  } else {
    throw "No Data Found";
  }
}