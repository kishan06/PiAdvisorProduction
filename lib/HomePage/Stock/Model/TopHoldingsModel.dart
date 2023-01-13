class topHoldingsModel {
  List<Table>? table;
  List<Table1>? table1;

  topHoldingsModel({this.table, this.table1});

  topHoldingsModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
    if (json['Table1'] != null) {
      table1 = <Table1>[];
      json['Table1'].forEach((v) {
        table1!.add(new Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    if (this.table1 != null) {
      data['Table1'] = this.table1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  String? fincode;
  String? compname;
  String? mKTVAL;
  String? holdPer;
  String? iNVDATE;
  String? rATING;
  String? aSECTTYPE;
  String? aSECTCODE;
  String? status;
  String? aUM;

  Table(
      {this.fincode,
      this.compname,
      this.mKTVAL,
      this.holdPer,
      this.iNVDATE,
      this.rATING,
      this.aSECTTYPE,
      this.aSECTCODE,
      this.status,
      this.aUM});

  Table.fromJson(Map<String, dynamic> json) {
    fincode = json['Fincode'];
    compname = json['Compname'];
    mKTVAL = json['MKTVAL'];
    holdPer = json['HoldPer'];
    iNVDATE = json['INVDATE'];
    rATING = json['RATING'];
    aSECTTYPE = json['ASECT_TYPE'];
    aSECTCODE = json['ASECT_CODE'];
    status = json['Status'];
    aUM = json['AUM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fincode'] = this.fincode;
    data['Compname'] = this.compname;
    data['MKTVAL'] = this.mKTVAL;
    data['HoldPer'] = this.holdPer;
    data['INVDATE'] = this.iNVDATE;
    data['RATING'] = this.rATING;
    data['ASECT_TYPE'] = this.aSECTTYPE;
    data['ASECT_CODE'] = this.aSECTCODE;
    data['Status'] = this.status;
    data['AUM'] = this.aUM;
    return data;
  }
}

class Table1 {
  String? totalRows;

  Table1({this.totalRows});

  Table1.fromJson(Map<String, dynamic> json) {
    totalRows = json['TotalRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRows'] = this.totalRows;
    return data;
  }
}
