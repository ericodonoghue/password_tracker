import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  bool isAuthenticated = false;

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      isAuthenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    return response.statusCode == 200;
  }

}
