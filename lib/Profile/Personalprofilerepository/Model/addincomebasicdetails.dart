class addincomebasicdetails {
  User? user;

  addincomebasicdetails({this.user});

  addincomebasicdetails.fromJson(Map<String, dynamic> json) {
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
  String? income;
  String? expense;
  String? assets;
  String? liabilities;
  int? termPlan;
  int? uILP;
  int? mediclaim;
  int? general;
  int? guaranteedIncome;
  int? pensionPlan;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.userId,
      this.income,
      this.expense,
      this.assets,
      this.liabilities,
      this.termPlan,
      this.uILP,
      this.mediclaim,
      this.general,
      this.guaranteedIncome,
      this.pensionPlan,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    income = json['Income'];
    expense = json['Expense'];
    assets = json['Assets'];
    liabilities = json['Liabilities'];
    termPlan = json['Term_Plan'];
    uILP = json['UILP'];
    mediclaim = json['Mediclaim'];
    general = json['General'];
    guaranteedIncome = json['Guaranteed_Income'];
    pensionPlan = json['Pension_plan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['Income'] = this.income;
    data['Expense'] = this.expense;
    data['Assets'] = this.assets;
    data['Liabilities'] = this.liabilities;
    data['Term_Plan'] = this.termPlan;
    data['UILP'] = this.uILP;
    data['Mediclaim'] = this.mediclaim;
    data['General'] = this.general;
    data['Guaranteed_Income'] = this.guaranteedIncome;
    data['Pension_plan'] = this.pensionPlan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}