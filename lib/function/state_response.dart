import 'dart:convert';

import 'package:covid_19/model/state_model.dart';
import 'package:covid_19/utils/api_string.dart';
import 'package:http/http.dart';

Future getStateResponse() async {
  Response res = await get(Uri.parse(ApiUtils.STATE_BASE_URL + ApiUtils.country + ApiUtils.status));
  if(res.statusCode == 200) {
    List<dynamic> data = jsonDecode(res.body);
    List state = data.map((e) => AllState.fromJson(e)).toList();
    return state;
  } else {
    throw "No Data Found";
  }
}