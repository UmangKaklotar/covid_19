import 'dart:convert';

import 'package:http/http.dart';

import '../model/state_model.dart';
import '../utils/api_string.dart';

Future getStateResponse() async {
  Response res = await get(Uri.parse(ApiUtils.STATE_BASE_URL + ApiUtils.country + ApiUtils.status),);
  print(res.statusCode);
  if(res.statusCode == 200) {
    List<dynamic> data = jsonDecode(res.body);
    List state = data.map((e) => AllState.fromJson(e)).toList();
    return state;
  } else {
    throw "No Data Found";
  }
}