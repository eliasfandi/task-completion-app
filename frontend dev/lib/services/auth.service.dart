import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;


class AuthService {
  // Login
  Future<String> login(String _email, String _password) async {
    // Simulate a future for response after 2 second.
    var url = 'http://192.168.137.1:5000';

    http.post(url, body:  {'email': _email, 'password': _password});
    String loginResult = await http.read(url);

    return 'success';
  }

  // Logout
  Future<void> logout() async {
    // Simulate a future for response after 1 second.
    return await new Future<void>.delayed(
        new Duration(
            seconds: 1
        )
    );
  }
}