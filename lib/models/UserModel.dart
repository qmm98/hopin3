import 'dart:convert';

enum Gender {
  male,
  female,
  nonBinary,
}

class UserModel {
  String name;
  Gender gender;
  String isdriver;
  String phone;
  String email;
  String carInfo;
  double rating;
  String uid;

  //
  //Constructor
  UserModel(
      {this.name,
      this.gender,
      this.phone,
      this.isdriver,
      this.email,
      this.carInfo,
      this.rating,
      this.uid});

  String getUrlFromNameHash({Gender genderInput}) {
    int id = this.name.hashCode % 100;
    switch (genderInput) {
      case Gender.male:
        return 'https://randomuser.me/api/portraits/men/$id.jpg';
        break;
      case Gender.female:
        return 'https://randomuser.me/api/portraits/women/$id.jpg';
        break;
      case Gender.nonBinary:
        return 'https://img.documentonews.gr/unsafe/1000x600/smart/http://img.dash.documentonews.gr/documento/imagegrid/2018/10/31/5bd98303cd3a18740d2cf935.jpg';
        break;
      default:
        return 'https://upload.wikimedia.org/wikipedia/en/0/00/The_Child_aka_Baby_Yoda_%28Star_Wars%29.jpg';
    }
  }

  @override
  String toString() {
    return 'UserModel(name: $name, gender: $gender, phone: $phone, email: $email, carInfo: $carInfo, rating: $rating, uid: $uid, isdriver: $isdriver)';
  }

  UserModel copyWith({
    String name,
    Gender gender,
    String phone,
    String isdriver,
    String uid,
    String email,
    String carInfo,
    double rating,
  }) {
    return UserModel(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      isdriver: isdriver ?? this.isdriver,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      carInfo: carInfo ?? this.carInfo,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender?.toString(),
      'phone': phone,
      'email': email,
      'isdriver': isdriver,
      'uid': uid,
      'carInfo': carInfo,
      'rating': rating,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    Gender gender;
    if (map['gender'] == 'Gender.male') {
      gender = Gender.male;
    } else if (map['gender'] == 'Gender.female') {
      gender = Gender.female;
    } else if (map['gender'] == 'Gender.nonBinary') {
      gender = Gender.nonBinary;
    } else {
      gender = null;
    }

    return UserModel(
      name: map['name'],
      gender: gender,
      phone: map['phone'],
      email: map['email'],
      isdriver: map['isdriver'],
      uid: map['uid'],
      carInfo: map['carInfo'],
      rating: map['rating'],
    );
  }

  String toJson() => json.encode(toMap());

  static UserModel fromJson(String source) => fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.name == name &&
        o.gender == gender &&
        o.phone == phone &&
        o.email == email &&
        o.isdriver == isdriver &&
        o.uid == uid &&
        o.carInfo == carInfo &&
        o.rating == rating;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        isdriver.hashCode ^
        carInfo.hashCode ^
        rating.hashCode;
  }
}
