class DocumentsUploadTaxPlanningModel {
  final int id;
  final int userId;
  final String form16ImgName;
  final String itrImgName;
  final String otherDocImgName;

  const DocumentsUploadTaxPlanningModel({
    required this.id,
    required this.userId,
    required this.form16ImgName,
    required this.itrImgName,
    required this.otherDocImgName,
  });

  factory DocumentsUploadTaxPlanningModel.fromJson(Map<String, dynamic> json) {
    return DocumentsUploadTaxPlanningModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      form16ImgName: json['form_16'] as String,
      itrImgName: json['last_year_itr'] as String,
      otherDocImgName: json['other_documents'] as String,
    );
  }
}
