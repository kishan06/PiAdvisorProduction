import 'package:http/http.dart' as http;
import 'package:piadvisory/Utils/Constants.dart';
import 'dart:convert';

import '../models/personal_info_tax_planning_model.dart';

Future<List<PersonalInfoTaxPlanningModel>>
    fetchPersonalInfoTaxPlanning() async {
  final response =
      await http.Client().get(Uri.parse('${ApiConstant.base}api/get_info'));
  final parsed = jsonDecode(response.body)['data'];
  return parsed
      .map<PersonalInfoTaxPlanningModel>(
          (json) => PersonalInfoTaxPlanningModel.fromJson(json))
      .toList();
}

Future<bool> addPersonalInfoTaxPlanning(
    int userId, String age, String maritalStatus) async {
  var response = await http.post(
    Uri.parse('${ApiConstant.base}api/add_info'),
    body: {
      "user_id": userId.toString(),
      "age": age,
      "marital_status": maritalStatus,
    },
  );
  if (response.statusCode == 200) return true;
  return false;
}
