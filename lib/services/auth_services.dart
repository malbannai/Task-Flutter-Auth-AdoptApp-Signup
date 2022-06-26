import 'package:adopt_app/services/clinet.dart';
import 'package:dio/dio.dart';

import '../models/user.dart';

class AuthServices {
  final Dio _dio = Dio();
  // final _baseUrl = 'https://coded-books-api-auth.herokuapp.com/';
  
  // Signup
  Future<String> signup({required User user}) async {
    late String token;
    try {
      Response response =
          await Client.dio.post('/signup', data: user.toJson());
      token = response.data["token"];
    } on DioError catch (error) {
      print(error);
    }
    return token;
  }

  // Signin
    Future<String> signin({required User user}) async {
    late String token;
    try {
      Response response = await Client.dio.post('/signin', data: user.toJson());
      token = response.data["token"];
    } on DioError catch (error) {
      print(error);
    }
    return token;
  }
}
