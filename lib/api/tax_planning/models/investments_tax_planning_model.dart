class InvestmentsTaxPlanningModel {
  final int id;
  final int userId;
  final String epfPpf;
  final String tutionFees;
  final String elss;
  final String nps;
  final String otherInvestments;
  final String employers;
  final String own;
  final String principalAmount;
  final String interestAmount;
  final String educationLoanInterest;
  final String depositsInterest;

  const InvestmentsTaxPlanningModel({
    required this.id,
    required this.userId,
    required this.epfPpf,
    required this.tutionFees,
    required this.elss,
    required this.nps,
    required this.otherInvestments,
    required this.employers,
    required this.own,
    required this.principalAmount,
    required this.interestAmount,
    required this.educationLoanInterest,
    required this.depositsInterest,
  });

  factory InvestmentsTaxPlanningModel.fromJson(Map<String, dynamic> json) {
    return InvestmentsTaxPlanningModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      epfPpf: json['epf_ppf'] as String,
      tutionFees: json['tution_fees'] as String,
      elss: json['elss'] as String,
      nps: json['nps'] as String,
      otherInvestments: json['other_investments'] as String,
      employers: json['employes'] as String,
      own: json['own'] as String,
      principalAmount: json['principle_amount'] as String,
      interestAmount: json['interest_amount'] as String,
      educationLoanInterest: json['education_loan_interest'] as String,
      depositsInterest: json['interest_from_deposits'] as String,
    );
  }
}
