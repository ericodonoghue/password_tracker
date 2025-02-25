class PasswordEntry {
  final String applicationName;
  final String applicationURL;
  final String username;
  final String password;
  final String? notes; // optional

  PasswordEntry({
    required this.applicationName,
    required this.applicationURL,
    required this.username,
    required this.password,
    this.notes,
  });

  // If /allPasswords only returns applicationName, you might parse partial data for a list
  // Then call /getPassword for details. We'll do a fromJson factory for the full payload:
  factory PasswordEntry.fromJson(Map<String, dynamic> json) {
    return PasswordEntry(
      applicationName: json["applicationName"],
      applicationURL: json["applicationURL"],
      username: json["username"],
      password: json["password"],
      notes: json["notes"],
    );
  }
}
