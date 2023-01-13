class BankModel {
  String? message;
  List<BankData>? bankData;

  BankModel({this.message, this.bankData});

  BankModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['bankData'] != null) {
      bankData = <BankData>[];
      json['bankData'].forEach((v) {
        bankData!.add(new BankData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.bankData != null) {
      data['bankData'] = this.bankData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankData {
  int? id;
  int? userId;
  String? bankName;
  String? accountHolderName;
  String? accountNumber;
  String? iFSC;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  BankData(
      {this.id,
      this.userId,
      this.bankName,
      this.accountHolderName,
      this.accountNumber,
      this.iFSC,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  BankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bankName'];
    accountHolderName = json['accountHolderName'];
    accountNumber = json['accountNumber'];
    iFSC = json['IFSC'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bankName'] = this.bankName;
    data['accountHolderName'] = this.accountHolderName;
    data['accountNumber'] = this.accountNumber;
    data['IFSC'] = this.iFSC;
    data['isActive'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
