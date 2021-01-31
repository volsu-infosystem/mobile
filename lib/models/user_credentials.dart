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
    print("ed__ UserCredentials.fromJson");
    return UserCredentials.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'token': token,
      'subgroup': subgroup,
    };
  }

  String toJson() {
    print("ed__ UserCredentials.toJson");
    return json.encode(this.toMap());
  }

  UserCredentials copy() {
    return UserCredentials(
      email: email,
      token: token,
      subgroup: subgroup,
    );
  }

  @override
  String toString() {
    String t;
    if (token == null) {
      t = "<NULL>";
    } else if (token.isEmpty) {
      t = "<EMPTY>";
    } else {
      t = "OK (length=${token.length})";
    }
    return 'UserCredentials{email: $email, token: $t, subgroup: $subgroup}';
  }
}
