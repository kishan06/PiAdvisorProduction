class kycbasicdetails {
  User? user;

  kycbasicdetails({this.user});

  kycbasicdetails.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? address;
  String? email;
  String? panNumber;
  String? dOB;
  int? mobNumber;
  int? age;
  String? occupation;
  String? gender;
  String? residentialStatus;
  String? lifeExpectancy;
  int? isApproved;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? deletedAt;

  User(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.address,
      this.email,
      this.panNumber,
      this.dOB,
      this.mobNumber,
      this.age,
      this.occupation,
      this.gender,
      this.residentialStatus,
      this.lifeExpectancy,
      this.isApproved,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    email = json['email'];
    panNumber = json['pan_number'];
    dOB = json['DOB'];
    mobNumber = json['mob_number'];
    age = json['age'];
    occupation = json['occupation'];
    gender = json['gender'];
    residentialStatus = json['residential_status'];
    lifeExpectancy = json['life_expectancy'];
    isApproved = json['isApproved'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['pan_number'] = this.panNumber;
    data['DOB'] = this.dOB;
    data['mob_number'] = this.mobNumber;
    data['age'] = this.age;
    data['occupation'] = this.occupation;
    data['gender'] = this.gender;
    data['residential_status'] = this.residentialStatus;
    data['life_expectancy'] = this.lifeExpectancy;
    data['isApproved'] = this.isApproved;
    data['isActive'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
