class tellusaboutyourself {
  List<Data>? data;

  tellusaboutyourself({this.data});

  tellusaboutyourself.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? age;
  String? levelOfFamiliarity;
  String? reasonOfInvesting;
  String? annualIncome;
  String? howLongPlanToInvest;
  String? howMuchYouHopeToInvest;
  String? noOfDependentPerson;
  String? portfolioLost15ormore;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.age,
      this.levelOfFamiliarity,
      this.reasonOfInvesting,
      this.annualIncome,
      this.howLongPlanToInvest,
      this.howMuchYouHopeToInvest,
      this.noOfDependentPerson,
      this.portfolioLost15ormore,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    age = json['age'];
    levelOfFamiliarity = json['level_of_familiarity'];
    reasonOfInvesting = json['reason_of_investing'];
    annualIncome = json['annual_income'];
    howLongPlanToInvest = json['how_long_plan_to_invest'];
    howMuchYouHopeToInvest = json['how_much_you_hope_to_invest'];
    noOfDependentPerson = json['no_of_dependent_person'];
    portfolioLost15ormore = json['portfolio_lost_15ormore'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['age'] = this.age;
    data['level_of_familiarity'] = this.levelOfFamiliarity;
    data['reason_of_investing'] = this.reasonOfInvesting;
    data['annual_income'] = this.annualIncome;
    data['how_long_plan_to_invest'] = this.howLongPlanToInvest;
    data['how_much_you_hope_to_invest'] = this.howMuchYouHopeToInvest;
    data['no_of_dependent_person'] = this.noOfDependentPerson;
    data['portfolio_lost_15ormore'] = this.portfolioLost15ormore;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
