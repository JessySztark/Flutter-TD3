import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PollsState extends ChangeNotifier {
  late String? _authToken;
  void setAuthToken(String? token) {
    _authToken = token;
  }

  Future<dynamic> getData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load data');
    }
  }
}
