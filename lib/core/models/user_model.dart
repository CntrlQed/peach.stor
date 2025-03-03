import 'dart:convert';

class User {
  String name;
  String email;
  String? phone;
  String? profilePicture;

  User({
    required this.name,
    required this.email,
    this.phone,
    this.profilePicture,
  });

  // Create a copy of the user with optional new values
  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? profilePicture,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  // Convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profilePicture': profilePicture,
    };
  }

  // Create User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );
  }

  // Convert to JSON string
  String toJsonString() => jsonEncode(toJson());

  // Create from JSON string
  factory User.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return User.fromJson(json);
  }
} 