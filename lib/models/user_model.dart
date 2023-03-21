import 'package:flutter/foundation.dart';


class UserModel {
  final String email;
  final String name;
  final String uid;
  final String password;
  final String dob;
  final String gender;
  final String phone;
  final String profilePhotoUrl;
  
  const UserModel({
    required this.email,
    required this.name,
    
    required this.uid,
    required this.password,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.profilePhotoUrl
    
  });

  UserModel copyWith({
    String? email,
    String? name,
    
    String? uid,
    String? password,
    String? dob,
    String? gender,
    String? phone,
    String? profilePhotoUrl,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
     
      uid: uid ?? this.uid,
      password: password?? this.password,
      dob: dob?? this.dob,
      gender: gender?? this.gender,
      phone: phone?? this.password,
      profilePhotoUrl: profilePhotoUrl?? this.profilePhotoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'password': password});
    result.addAll({'uid': uid});
    result.addAll({'dob': dob});
    result.addAll({'gender': gender});
    result.addAll({'phone': phone});
    result.addAll({'profilePhotoUrl':profilePhotoUrl});
   

    return result;
  }
  
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      
      uid: map['\$id'] ?? '',
      password: map['password'] ?? '',
      dob: map['dob']??'',
      gender: map['gender'] ?? '',
      phone: map['phone']??'',
      profilePhotoUrl: map['profilePhotoUrl']??''
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name,  uid: $uid, password: $password, dob: $dob, gender: $gender, phone: $phone, profilePhotoUrl: $profilePhotoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        
        other.uid == uid &&
        other.password == password &&
        other.dob == dob &&
        other.phone == phone &&
        other.gender == gender &&
        other.profilePhotoUrl == profilePhotoUrl;
        
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        
        uid.hashCode ^
        password.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        profilePhotoUrl.hashCode;
  }
}