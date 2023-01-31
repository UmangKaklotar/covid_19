import 'dart:convert';

import 'package:covid_19/model/covid_model.dart';
import 'package:covid_19/utils/api_string.dart';
import 'package:http/http.dart';

class HttpService {
  Future getCovidResponse() async {
    Response res = await get(Uri.parse(ApiUtils.BASE_URL));
    if(res.statusCode == 200){
      List<dynamic> data = jsonDecode(res.body);
      List covid = data.map((e) => Covid.fromJson(e)).toList();
      return covid;
    } else {
      throw "No Data Found";
    }
  }
}