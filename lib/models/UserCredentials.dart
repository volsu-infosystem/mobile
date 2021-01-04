import 'dart:convert';

class UserCredentials {
  String email;
  String token;
  int subgroup;

  UserCredentials({this.email, this.token, this.subgroup});

  bool get isReady {
    return email != null &&
        token != null &&
        email.isNotEmpty &&
        token.isNotEmpty &&
        subgroup != null;
  }

  UserCredentials.fromMap(Map<String, dynamic> json)
      : email = json['email'],
        token = json['token'],
        subgroup = json['subgroup'];

  static UserCredentials fromJson(String json) {
    return UserCredentials.fromMap(jsonDecode(json));
  }

  String toJson() => json.encode(this);
}
