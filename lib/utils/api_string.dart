import 'package:flutter/cupertino.dart';

class ApiUtils {
  static String BASE_URL = "https://disease.sh/v3/covid-19/countries";
  static final search = ValueNotifier<String>('');
}