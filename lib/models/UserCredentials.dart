import 'dart:convert';

class UserCredentials {
  String email;
  String token;
  int subgroup;

  UserCredentials({this.email, this.token, this.subgroup});

  bool get hasCorrectEmail => email != null && email.isNotEmpty;
  bool get hasCorrectToken => token != null && token.isNotEmpty;
  bool get hasCorrectSubgroup => true; // TODO subgroup != null;

  bool get isReady {
    return hasCorrectEmail && hasCorrectToken && hasCorrectSubgroup;
  }

  UserCredentials.fromMap(Map<String, dynamic> json)
      : email = json['email'],
        token = json['token'],
        subgroup = json['subgroup'];

  static UserCredentials fromJson(String json) {
    return UserCredentials.fromMap(jsonDecode(json));
  }

  String toJson() => json.encode(this);

  UserCredentials copy() {
    return UserCredentials(
      email: email,
      token: token,
      subgroup: subgroup,
    );
  }
}
