import 'package:flutter/cupertino.dart';

class ApiUtils {
  static String COUNTRY_BASE_URL = "https://disease.sh/v3/covid-19/countries";
  static String STATE_BASE_URL = "https://api.covid19api.com/live/country/";
  static String country = "india";
  static String status = "/status/status";
  static final searchCountry = ValueNotifier<String>('');
  static final searchState = ValueNotifier<String>('');
}