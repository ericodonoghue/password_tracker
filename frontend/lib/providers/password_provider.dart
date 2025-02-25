import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/models/password_entry.dart';

class PasswordProvider with ChangeNotifier {
  // Store all applicationNames we fetched from /allPasswords
  List<String> _applicationNames = [];
  List<String> get applicationNames => _applicationNames;

  // For displaying full details when user clicks
  PasswordEntry? _selectedEntry;
  PasswordEntry? get selectedEntry => _selectedEntry;

  // Fetch all application names from /allPasswords
  Future<void> fetchAllPasswords() async {
    final response = await http.get(
      Uri.parse("http://localhost:8080/api/password/allPasswords"),
      // If you have auth headers, you might add them here
    );
    if (response.statusCode == 200) {
      // Suppose the backend returns ["Gmail","Github","Slack","..."]
      List<dynamic> data = json.decode(response.body);
      _applicationNames = data.map((item) => item.toString()).toList();
      notifyListeners();
    } else {
      // handle error
      print("Error fetching passwords: ${response.body}");
    }
  }

  // Get full data for a password entry
  Future<void> getPasswordDetails(String applicationName) async {
    final uri = Uri.parse("http://localhost:8080/api/password/getPassword?applicationName=$applicationName");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // Now _selectedEntry holds the full details
      _selectedEntry = PasswordEntry.fromJson(data);
      notifyListeners();
    } else {
      print("Error fetching details for $applicationName: ${response.body}");
    }
  }

  // Create a new password entry
  Future<bool> createNewPassword({
    required String applicationName,
    required String applicationURL,
    required String username,
    required String password,
    String? notes,
  }) async {
    final body = {
      "applicationName": applicationName,
      "applicationURL": applicationURL,
      "username": username,
      "password": password,
      "notes": notes ?? "",
    };
    final response = await http.post(
      Uri.parse("http://localhost:8080/api/password/newPassword"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // Successfully created, we can refetch the list
      await fetchAllPasswords();
      return true;
    } else {
      print("Error creating password: ${response.body}");
      return false;
    }
  }
}
