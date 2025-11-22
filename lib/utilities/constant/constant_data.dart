import 'dart:io';

class ConstantData {
  static const String APP_NAME = "NEATNEST";
  static const int APP_VERSION = 1;
  static final BASE_URL = Platform.isAndroid
      ? "http://10.0.2.2:8000/api/v1"
      : "http://127.0.0.1:8000/api/v1";
  static const LOGIN = "/auth/login";
  static const REGISTER = "/auth/register";
  static const QUERY = "/ads";
  static const PAYMENTMETHOd = "/payment-method";
  static const ADDRESS = "/user-address";
  static const GETCOUNTRIES = "/address/countries";
  static const GETSTATE = "/address/states";
  static const UPDATEPASSWORD = "/auth/updatepassword";
}
