class familybasicdetails {
  User? user;

  familybasicdetails({this.user});

  familybasicdetails.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? userId;
  String? fathersName;
  String? fathersOccupation;
  String? fathersDob;
  String? fathersAge;
  String? mothersName;
  String? mothersOccupation;
  String? mothersAge;
  String? mothersDob;
  String? husbandWifeName;
  String? husbandWifeOccupation;
  String? husbandWifeDob;
  String? husbandWifeAge;
  String? children;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.userId,
      this.fathersName,
      this.fathersOccupation,
      this.fathersDob,
      this.fathersAge,
      this.mothersName,
      this.mothersOccupation,
      this.mothersAge,
      this.mothersDob,
      this.husbandWifeName,
      this.husbandWifeOccupation,
      this.husbandWifeDob,
      this.husbandWifeAge,
      this.children,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fathersName = json['Fathers_name'];
    fathersOccupation = json['fathers_occupation'];
    fathersDob = json['fathers_dob'];
    fathersAge = json['fathers_age'];
    mothersName = json['Mothers_name'];
    mothersOccupation = json['mothers_occupation'];
    mothersAge = json['mothers_age'];
    mothersDob = json['mothers_dob'];
    husbandWifeName = json['Husband_wife_name'];
    husbandWifeOccupation = json['Husband_wife_occupation'];
    husbandWifeDob = json['Husband_wife_dob'];
    husbandWifeAge = json['Husband_wife_age'];
    children = json['children'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['Fathers_name'] = this.fathersName;
    data['fathers_occupation'] = this.fathersOccupation;
    data['fathers_dob'] = this.fathersDob;
    data['fathers_age'] = this.fathersAge;
    data['Mothers_name'] = this.mothersName;
    data['mothers_occupation'] = this.mothersOccupation;
    data['mothers_age'] = this.mothersAge;
    data['mothers_dob'] = this.mothersDob;
    data['Husband_wife_name'] = this.husbandWifeName;
    data['Husband_wife_occupation'] = this.husbandWifeOccupation;
    data['Husband_wife_dob'] = this.husbandWifeDob;
    data['Husband_wife_age'] = this.husbandWifeAge;
    data['children'] = this.children;
    data['isActive'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
