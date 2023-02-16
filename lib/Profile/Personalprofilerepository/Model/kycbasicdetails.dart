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
  String? sourceOfWealth;
  String? placeOfBirth;
  String? incomeSlab;
  String? accountType;
  String? dividendPaymode;
  String? gender;
  String? residentialStatus;
  int? isActive;
  String? createdAt;
  String? updatedAt;

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
      this.sourceOfWealth,
      this.placeOfBirth,
      this.incomeSlab,
      this.accountType,
      this.dividendPaymode,
      this.gender,
      this.residentialStatus,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    email = json['email'];
    panNumber = json['pan_number'];
    dOB = json['DOB'];
    mobNumber = json['mob_number'];
    age = json['age'];
    occupation = json['occupation'];
    sourceOfWealth = json['source_of_wealth'];
    placeOfBirth = json['place_of_birth'];
    incomeSlab = json['Income_slab'];
    accountType = json['account_type'];
    dividendPaymode = json['dividend_paymode'];
    gender = json['gender'];
    residentialStatus = json['residential_status'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['pan_number'] = this.panNumber;
    data['DOB'] = this.dOB;
    data['mob_number'] = this.mobNumber;
    data['age'] = this.age;
    data['occupation'] = this.occupation;
    data['source_of_wealth'] = this.sourceOfWealth;
    data['place_of_birth'] = this.placeOfBirth;
    data['Income_slab'] = this.incomeSlab;
    data['account_type'] = this.accountType;
    data['dividend_paymode'] = this.dividendPaymode;
    data['gender'] = this.gender;
    data['residential_status'] = this.residentialStatus;
    data['isActive'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
