import 'package:http/http.dart' as http;
import 'package:piadvisory/Utils/Constants.dart';
import 'dart:convert';

import '../models/insurance_premium_tax_planning_model.dart';

Future<List<InsurancePremiumTaxPlanningModel>>
    fetchInsurancePremiumTaxPlanning() async {
  final response = await http.Client()
      .get(Uri.parse('${ApiConstant.base}api/get_insurance'));
  final parsed = jsonDecode(response.body)['data'];
  return parsed
      .map<InsurancePremiumTaxPlanningModel>(
          (json) => InsurancePremiumTaxPlanningModel.fromJson(json))
      .toList();
}

Future<bool> addInsuranceTaxPlanning(
  String userId,
  String lifeInsurance,
  String healthInsurance,
  String preventiveHealthCheckup,
  String parentsHealthInsurance,
  String areParentsSeniorCitizen,
  String medicalExpanditureAmount,
) async {
  var response = await http.post(
    Uri.parse('${ApiConstant.base}api/add_insurance'),
    body: {
      "user_id": userId,
      "life_insurance": lifeInsurance,
      "health_insurance": healthInsurance,
      "preventive_health_check_up": preventiveHealthCheckup,
      "parents_heath_insurance": parentsHealthInsurance,
      "parents_senior_citizen": areParentsSeniorCitizen,
      "medical_expenditure_amount": medicalExpanditureAmount
    },
  );
  if (response.statusCode == 200) return true;
  return false;
}
