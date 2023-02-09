class UserRealestate {
  List<UserRe>? userRe;

  UserRealestate({this.userRe});

  UserRealestate.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      userRe = <UserRe>[];
      json['user'].forEach((v) {
        userRe!.add(new UserRe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userRe != null) {
      data['user'] = this.userRe!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRe {
  int? id;
  int? userId;
  String? propertyName;
  String? investedValue;
  String? dateOfInvestment;
  String? currentValue;
  String? createdAt;
  String? updatedAt;

  UserRe(
      {this.id,
      this.userId,
      this.propertyName,
      this.investedValue,
      this.dateOfInvestment,
      this.currentValue,
      this.createdAt,
      this.updatedAt});

  UserRe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    propertyName = json['property_name'];
    investedValue = json['invested_value'];
    dateOfInvestment = json['date_of_investment'];
    currentValue = json['current_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['property_name'] = this.propertyName;
    data['invested_value'] = this.investedValue;
    data['date_of_investment'] = this.dateOfInvestment;
    data['current_value'] = this.currentValue;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}