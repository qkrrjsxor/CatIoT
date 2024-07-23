import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookieManager {
  static final CookieManager _instance = CookieManager._internal();
  final CookieJar _cookieJar = CookieJar();

  factory CookieManager() {
    return _instance;
  }

  CookieManager._internal();

  Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) async {
    _cookieJar.saveFromResponse(uri, cookies);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cookiesString =
        cookies.map((cookie) => cookie.toString()).toList();
    prefs.setStringList('cookies', cookiesString);
  }

  Future<List<Cookie>> loadForRequest(Uri uri) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cookiesString = prefs.getStringList('cookies');
    if (cookiesString != null) {
      List<Cookie> cookies =
          cookiesString.map((str) => Cookie.fromSetCookieValue(str)).toList();
      _cookieJar.saveFromResponse(uri, cookies);
    }
    return _cookieJar.loadForRequest(uri);
  }

  void clear() {
    _cookieJar.deleteAll();
  }
}
