import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../configs.dart';
import '../models/user.dart';

class AuthState extends ChangeNotifier {
  AuthState();
  User? _currentUser;
  User? get currentUser => _currentUser;
  String? _token;
  String? get token => _token;
  bool get isLoggedIn => currentUser != null;

  Future<User?> login(String username, String password) async {
    final loginResponse = await http.post(
      Uri.parse('${Configs.baseUrl}/auth/login'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    if (loginResponse.statusCode == HttpStatus.ok) {
      _token = json.decode(loginResponse.body)['token'];
      final userResponse = await http.get(
        Uri.parse('${Configs.baseUrl}/users/me'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (userResponse.statusCode == HttpStatus.ok) {
        _currentUser = User.fromJson(json.decode(userResponse.body));
        notifyListeners();
        return _currentUser;
      }
    }
    logout();
    return null;
  }

  Future<User?> signup(String username, String password) async {
    final signUp = await http.post(
      Uri.parse('${Configs.baseUrl}/auth/signup'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    if (signUp.statusCode == HttpStatus.ok) {
      _token = json.decode(signUp.body)['token'];
      final userResponse = await http.get(
        Uri.parse('${Configs.baseUrl}/users/me'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (userResponse.statusCode == HttpStatus.ok) {
        _currentUser = User.fromJson(json.decode(userResponse.body));
        notifyListeners();
        return _currentUser;
      }
    }
    login(username, password);
    return null;
  }

  void logout() {
    _token = null;
    _currentUser = null;
    notifyListeners();
  }
}
