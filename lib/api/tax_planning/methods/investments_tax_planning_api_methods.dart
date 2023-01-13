import 'package:http/http.dart' as http;
import 'package:piadvisory/Utils/Constants.dart';
import 'dart:convert';

import '../models/investments_tax_planning_model.dart';

Future<List<InvestmentsTaxPlanningModel>> fetchInvestmentsTaxPlanning() async {
  final response = await http.Client()
      .get(Uri.parse('${ApiConstant.base}api/get_investment'));
  final parsed = jsonDecode(response.body)['data'];
  return parsed
      .map<InvestmentsTaxPlanningModel>(
          (json) => InvestmentsTaxPlanningModel.fromJson(json))
      .toList();
}

Future<bool> addInvestmentsTaxPlanning(
  String userId,
  String epfPpf,
  String tutionFees,
  String elss,
  String nps,
  String otherInvestments,
  String employes,
  String own,
  String principalAmount,
  String interestAmount,
  String educationLoanInterest,
  String depositsInterest,
) async {
  var response = await http.post(
    Uri.parse('${ApiConstant.base}api/add_investment'),
    body: {
      "user_id": userId,
      "epf_ppf": epfPpf,
      "tution_fees": tutionFees,
      "elss": elss,
      "nps": nps,
      "other_investments": otherInvestments,
      "employes": employes,
      "own": own,
      "principle_amount": principalAmount,
      "interest_amount": interestAmount,
      "education_loan_interest": educationLoanInterest,
      "interest_from_deposits": depositsInterest,
    },
  );
  if (response.statusCode == 200) return true;
  return false;
}
