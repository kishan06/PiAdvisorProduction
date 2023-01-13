class PersonalInfoTaxPlanningModel {
  final int id;
  final int userId;
  final int age;
  final String maritalStatus;

  const PersonalInfoTaxPlanningModel({
    required this.id,
    required this.userId,
    required this.age,
    required this.maritalStatus,
  });

  factory PersonalInfoTaxPlanningModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoTaxPlanningModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      age: json['age'] as int,
      maritalStatus: json['marital_status'] as String,
    );
  }
}
