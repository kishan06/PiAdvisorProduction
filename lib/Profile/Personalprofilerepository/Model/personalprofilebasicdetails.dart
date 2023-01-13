class personalprofilebasicdetails {
  User? user;

  personalprofilebasicdetails({this.user});

  personalprofilebasicdetails.fromJson(Map<String, dynamic> json) {
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
  String? fullname;
  String? mobNumber;
  String? emailId;
  String? dob;
  String? occupation;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? aadharNumber;
  String? panNumber;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.userId,
      this.fullname,
      this.mobNumber,
      this.emailId,
      this.dob,
      this.occupation,
      this.address,
      this.city,
      this.state,
      this.pincode,
      this.aadharNumber,
      this.panNumber,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullname = json['fullname'];
    mobNumber = json['mob_number'];
    emailId = json['email_id'];
    dob = json['dob'];
    occupation = json['occupation'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    aadharNumber = json['aadhar_number'];
    panNumber = json['pan_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['fullname'] = this.fullname;
    data['mob_number'] = this.mobNumber;
    data['email_id'] = this.emailId;
    data['dob'] = this.dob;
    data['occupation'] = this.occupation;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['aadhar_number'] = this.aadharNumber;
    data['pan_number'] = this.panNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}