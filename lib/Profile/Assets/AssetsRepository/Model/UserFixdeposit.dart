class UserFixdeposit {
  List<Userfd>? user;

  UserFixdeposit({this.user});

  UserFixdeposit.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <Userfd>[];
      json['user'].forEach((v) {
        user!.add(new Userfd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userfd {
  int? id;
  int? userId;
  String? bankName;
  String? investmentAmount;
  String? annualRate;
  String? startDate;
  String? tenure;
  String? createdAt;
  String? updatedAt;

  Userfd(
      {this.id,
      this.userId,
      this.bankName,
      this.investmentAmount,
      this.annualRate,
      this.startDate,
      this.tenure,
      this.createdAt,
      this.updatedAt});

  Userfd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    investmentAmount = json['investment_amount'];
    annualRate = json['annual_rate'];
    startDate = json['start_date'];
    tenure = json['tenure'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bank_name'] = this.bankName;
    data['investment_amount'] = this.investmentAmount;
    data['annual_rate'] = this.annualRate;
    data['start_date'] = this.startDate;
    data['tenure'] = this.tenure;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
