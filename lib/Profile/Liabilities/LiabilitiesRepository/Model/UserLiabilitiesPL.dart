class UserLiabilitiesPL {
  List<UserPL>? user;

  UserLiabilitiesPL({this.user});

  UserLiabilitiesPL.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <UserPL>[];
      json['user'].forEach((v) {
        user!.add(new UserPL.fromJson(v));
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

class UserPL {
  int? id;
  int? userId;
  int? totalLoan;
  String? loanIssuedOn;
  int? loanTenure;
  int? installmentAmount;
  int? frequencyPayment;
  int? rateOfInterest;
  String? createdAt;
  String? updatedAt;

  UserPL(
      {this.id,
      this.userId,
      this.totalLoan,
      this.loanIssuedOn,
      this.loanTenure,
      this.installmentAmount,
      this.frequencyPayment,
      this.rateOfInterest,
      this.createdAt,
      this.updatedAt});

  UserPL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalLoan = json['total_loan'];
    loanIssuedOn = json['loan_issued_on'];
    loanTenure = json['loan_tenure'];
    installmentAmount = json['installment_amount'];
    frequencyPayment = json['frequency_payment'];
    rateOfInterest = json['rate_of_interest'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['total_loan'] = this.totalLoan;
    data['loan_issued_on'] = this.loanIssuedOn;
    data['loan_tenure'] = this.loanTenure;
    data['installment_amount'] = this.installmentAmount;
    data['frequency_payment'] = this.frequencyPayment;
    data['rate_of_interest'] = this.rateOfInterest;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
