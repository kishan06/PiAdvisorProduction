class InsurancePremiumTaxPlanningModel {
  final int id;
  final int userId;
  final String lifeInsurance;
  final String healthInsurance;
  final String preventiveHealthCheckup;
  final String parentsHealthInsurace;
  final String areParentsSeniorCitizens;
  final String medicalExpenditureAmount;

  const InsurancePremiumTaxPlanningModel({
    required this.id,
    required this.userId,
    required this.lifeInsurance,
    required this.healthInsurance,
    required this.preventiveHealthCheckup,
    required this.parentsHealthInsurace,
    required this.areParentsSeniorCitizens,
    required this.medicalExpenditureAmount,
  });

  factory InsurancePremiumTaxPlanningModel.fromJson(Map<String, dynamic> json) {
    return InsurancePremiumTaxPlanningModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      lifeInsurance: json['life_insurance'] as String,
      healthInsurance: json['health_insurance'] as String,
      preventiveHealthCheckup: json['preventive_health_check_up'] as String,
      parentsHealthInsurace: json['parents_heath_insurance'] as String,
      areParentsSeniorCitizens: json['parents_senior_citizen'] as String,
      medicalExpenditureAmount: json['medical_expenditure_amount'] as String,
    );
  }
}
