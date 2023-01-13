class PiRecommendedModel {
  Data? data;

  PiRecommendedModel({this.data});

  PiRecommendedModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ManageStockAdvisors>? manageStockAdvisors;
  List<ManageMfAdvisors>? manageMfAdvisors;

  Data({this.manageStockAdvisors, this.manageMfAdvisors});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['manage_stock_advisors'] != null) {
      manageStockAdvisors = <ManageStockAdvisors>[];
      json['manage_stock_advisors'].forEach((v) {
        manageStockAdvisors!.add(new ManageStockAdvisors.fromJson(v));
      });
    }
    if (json['manage_mf_advisors'] != null) {
      manageMfAdvisors = <ManageMfAdvisors>[];
      json['manage_mf_advisors'].forEach((v) {
        manageMfAdvisors!.add(new ManageMfAdvisors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.manageStockAdvisors != null) {
      data['manage_stock_advisors'] =
          this.manageStockAdvisors!.map((v) => v.toJson()).toList();
    }
    if (this.manageMfAdvisors != null) {
      data['manage_mf_advisors'] =
          this.manageMfAdvisors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManageStockAdvisors {
  int? id;
  int? userId;
  String? stockName;
  String? fincode;
  String? price;
  String? quantity;
  String? buyOrSell;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? ticker;//bsc ticker

  ManageStockAdvisors(
      {this.id,
      this.userId,
      this.stockName,
      this.fincode,
      this.price,
      this.quantity,
      this.buyOrSell,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.ticker,});

  ManageStockAdvisors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    stockName = json['stock_name'];
    fincode = json['fincode'];
    price = json['price'];
    quantity = json['quantity'];
    buyOrSell = json['buy_or_sell'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ticker = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['stock_name'] = this.stockName;
    data['fincode'] = this.fincode;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['buy_or_sell'] = this.buyOrSell;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['symbol'] = this.ticker;
    return data;
  }
}

class ManageMfAdvisors {
  int? id;
  int? userId;
  String? mutualFundName;
  String? price;
  String? type;
  String? frequency;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  ManageMfAdvisors(
      {this.id,
      this.userId,
      this.mutualFundName,
      this.price,
      this.type,
      this.frequency,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  ManageMfAdvisors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mutualFundName = json['mutual_fund_name'];
    price = json['price'];
    type = json['type'];
    frequency = json['frequency'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['mutual_fund_name'] = this.mutualFundName;
    data['price'] = this.price;
    data['type'] = this.type;
    data['frequency'] = this.frequency;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
