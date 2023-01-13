import 'package:http/http.dart' as http;
import 'package:piadvisory/Utils/Constants.dart';
import 'dart:convert';

import '../models/income_details_tax_planning_model.dart';

Future<List<IncomeDetailsTaxPlanningModel>>
    fetchIncomeDetailsTaxPlanning() async {
  final response =
      await http.Client().get(Uri.parse('${ApiConstant.base}api/get_income'));
  final parsed = jsonDecode(response.body)['data'];
  return parsed
      .map<IncomeDetailsTaxPlanningModel>(
          (json) => IncomeDetailsTaxPlanningModel.fromJson(json))
      .toList();
}

Future<bool> addIncomeDetailsTaxPlanning(
  String userId,
  String allSourceIncome,
  String isSalaried,
  String houseRentPayable,
) async {
  var response = await http.post(
    Uri.parse('${ApiConstant.base}api/add_income'),
    body: {
      "user_id": userId,
      "income_from_all_source": allSourceIncome,
      "are_you_salaried": isSalaried,
      "house_rent_payable": houseRentPayable,
    },
  );
  if (response.statusCode == 200) return true;
  return false;
}
