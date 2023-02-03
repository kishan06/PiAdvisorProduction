class UserMutualfund {
  User? user;

  UserMutualfund({this.user});

  UserMutualfund.fromJson(Map<String, dynamic> json) {
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
  String? schemeName;
  int? investmentAmount;
  String? dateOfInvestment;
  int? currentValue;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.userId,
      this.schemeName,
      this.investmentAmount,
      this.dateOfInvestment,
      this.currentValue,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    schemeName = json['scheme_name'];
    investmentAmount = json['investment_amount'];
    dateOfInvestment = json['date_of_investment'];
    currentValue = json['current_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['scheme_name'] = this.schemeName;
    data['investment_amount'] = this.investmentAmount;
    data['date_of_investment'] = this.dateOfInvestment;
    data['current_value'] = this.currentValue;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}