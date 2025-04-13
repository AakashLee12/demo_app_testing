import 'dart:convert';

class UserDetails {
  final String userId;
  final String name;
  final String mobileNo;
  final String password;
  final String email;

  UserDetails({
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'mobileNo': mobileNo,
      'password': password,
      'email': email,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      userId: map['userId'] as String,
      name: map['name'] as String,
      mobileNo: map['mobileNo'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  // Override == operator and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetails &&
        other.userId == userId &&
        other.name == name &&
        other.mobileNo == mobileNo &&
        other.password == password &&
        other.email == email;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        mobileNo.hashCode ^
        password.hashCode ^
        email.hashCode;
  }

  UserDetails copyWith({
    String? userId,
    String? name,
    String? mobileNo,
    String? password,
    String? email,
  }) {
    return UserDetails(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      mobileNo: mobileNo ?? this.mobileNo,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }
}
