import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:piadvisory/Utils/Constants.dart';

import '../models/documents_upload_tax_planning_model.dart';

Future<bool> uploadItrNOther(String userId, XFile ItrImg, XFile otherImg) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("${ApiConstant.base}api/add_document"));
  request.fields["user_id"] = userId;
  var pic1 = await http.MultipartFile.fromPath("last_year_itr", ItrImg.path);
  var pic2 = await http.MultipartFile.fromPath("other_documents", otherImg.path);
  request.files.addAll([pic1,pic2]);
  var response = await request.send();
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> uploadFrom16NOther(String userId, XFile form16Img, XFile otherImg) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("${ApiConstant.base}api/add_document"));
  request.fields["user_id"] = userId;
  var pic1 = await http.MultipartFile.fromPath("form_16", form16Img.path);
  var pic2 = await http.MultipartFile.fromPath("other_documents", otherImg.path);
  request.files.addAll([pic1,pic2]);
  var response = await request.send();
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> uploadFrom16NItr(String userId, XFile form16Img, XFile itrImg) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("${ApiConstant.base}api/add_document"));
  request.fields["user_id"] = userId;
  var pic1 = await http.MultipartFile.fromPath("form_16", form16Img.path);
  var pic2 = await http.MultipartFile.fromPath("last_year_itr", itrImg.path);
  request.files.addAll([pic1,pic2]);
  var response = await request.send();
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> uploadFrom16(String userId, XFile form16Img) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("${ApiConstant.base}api/add_document"));
  request.fields["user_id"] = userId;
  var pic = await http.MultipartFile.fromPath("form_16", form16Img.path);
  request.files.add(pic);
  var response = await request.send();
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> uploadItr(String userId, XFile itrImg) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("${ApiConstant.base}api/add_document"));
  request.fields["user_id"] = userId;
  var pic = await http.MultipartFile.fromPath("last_year_itr", itrImg.path);
  request.files.add(pic);
  var response = await request.send();
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> uploadOtherDocs(String userId, XFile otherDocsImg) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("${ApiConstant.base}api/add_document"));
  request.fields["user_id"] = userId;
  var pic = await http.MultipartFile.fromPath("other_documents", otherDocsImg.path);
  request.files.add(pic);
  var response = await request.send();
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<bool> addDocuments(String userId, XFile? form16Img, XFile? itrImg,
    XFile? otherDocumentsImg) async {
  var request = http.MultipartRequest(
      "POST", Uri.parse("${ApiConstant.base}api/add_document"));
  request.fields["user_id"] = userId;
  var pic1 =
      await http.MultipartFile.fromPath("form_16", form16Img?.path ?? "NULL");
  var pic2 = await http.MultipartFile.fromPath(
      "last_year_itr", itrImg?.path ?? "NULL");
  var pic3 = await http.MultipartFile.fromPath(
      "other_documents", otherDocumentsImg?.path ?? "NULL");
  request.files.addAll([pic1, pic2, pic3]);
  var response = await request.send();
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}

Future<List<DocumentsUploadTaxPlanningModel>>
    fetchDocumentsTaxPlanning() async {
  final response =
      await http.Client().get(Uri.parse('${ApiConstant.base}api/get_document'));
  final parsed = jsonDecode(response.body)['data'];
  return parsed
      .map<DocumentsUploadTaxPlanningModel>(
          (json) => DocumentsUploadTaxPlanningModel.fromJson(json))
      .toList();
}

/*
{"message":"Documents Updated succcessfully"}
*/
