import 'dart:io';

import 'package:adopt_app/services/clinet.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../models/user.dart';
import '../services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String token = "";
  late User user;
  bool get isAuth {
    getToken();
    if (token.isNotEmpty && Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
      user = User.fromJson(Jwt.parseJwt(token));
      Client.dio.options.headers = {
        HttpHeaders.authorizationHeader: "Bearer $token",
      };
      return true;
    }
    logout();
    return false;
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }

  void signup({required User user}) async {
    token = await AuthServices().signup(user: user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print(token);
    notifyListeners();
  }

  void signin({required User user}) async {
    token = await AuthServices().signin(user: user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print(token);
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    token = "";
    notifyListeners();
  }
}
