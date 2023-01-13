class IncomeDetailsTaxPlanningModel {
  final int id;
  final int userId;
  final String allSourceIncome;
  final int isSalaried;
  final String houseRentPayable;

  const IncomeDetailsTaxPlanningModel({
    required this.id,
    required this.userId,
    required this.allSourceIncome,
    required this.isSalaried,
    required this.houseRentPayable,
  });

  factory IncomeDetailsTaxPlanningModel.fromJson(Map<String, dynamic> json) {
    return IncomeDetailsTaxPlanningModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      allSourceIncome: json['income_from_all_source'] as String,
      isSalaried: json['are_you_salaried'] as int,
      houseRentPayable: json['house_rent_payable'] as String,
    );
  }
}
