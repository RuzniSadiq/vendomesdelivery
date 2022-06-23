class UserModel {
  String? email;
  String? role;
  String? uid;
  String? name;
  String? mobile;


// receiving data
  UserModel(
      {this.uid,
      this.email,
      this.role,
      this.name,
      this.mobile,});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      role: map['role'],
      name: map['name'],
      mobile: map['mobile'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'name': name,
      'mobile': mobile,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        email: json['email'],
        role: json['role'],
        name: json['name'],
        mobile: json['mobile'],
      );
}
