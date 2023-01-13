class GetSchemeDataModel {
  List<Table>? table;
  List<Table1>? table1;

  GetSchemeDataModel({this.table, this.table1});

  GetSchemeDataModel.fromJson(Map<String, dynamic> json) {
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
  String? sRNO;
  String? sCHEMECODE;
  String? sCHEMENAME;
  String? aMCCODE;
  String? aMC;
  String? aSSETTYPE;
  String? cATEGORYCODE;
  String? cATEGORYNAME;
  String? rISK;
  String? nAVDATE;
  String? nAV;
  String? cHANGE;
  String? cHANGEPERC;
  String? s1MONTHRET;
  String? s3MONTHRET;
  String? s6MONTHRET;
  String? s1YRRET;
  String? s3YEARRET;
  String? s5YEARRET;
  String? iNCRET;

  Table(
      {this.sRNO,
      this.sCHEMECODE,
      this.sCHEMENAME,
      this.aMCCODE,
      this.aMC,
      this.aSSETTYPE,
      this.cATEGORYCODE,
      this.cATEGORYNAME,
      this.rISK,
      this.nAVDATE,
      this.nAV,
      this.cHANGE,
      this.cHANGEPERC,
      this.s1MONTHRET,
      this.s3MONTHRET,
      this.s6MONTHRET,
      this.s1YRRET,
      this.s3YEARRET,
      this.s5YEARRET,
      this.iNCRET});

  Table.fromJson(Map<String, dynamic> json) {
    sRNO = json['SRNO'];
    sCHEMECODE = json['SCHEMECODE'];
    sCHEMENAME = json['SCHEME_NAME'];
    aMCCODE = json['AMC_CODE'];
    aMC = json['AMC'];
    aSSETTYPE = json['ASSET_TYPE'];
    cATEGORYCODE = json['CATEGORY_CODE'];
    cATEGORYNAME = json['CATEGORY_NAME'];
    rISK = json['RISK'];
    nAVDATE = json['NAVDATE'];
    nAV = json['NAV'];
    cHANGE = json['CHANGE'];
    cHANGEPERC = json['CHANGE_PERC'];
    s1MONTHRET = json['1MONTHRET'];
    s3MONTHRET = json['3MONTHRET'];
    s6MONTHRET = json['6MONTHRET'];
    s1YRRET = json['1YRRET'];
    s3YEARRET = json['3YEARRET'];
    s5YEARRET = json['5YEARRET'];
    iNCRET = json['INCRET'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SRNO'] = this.sRNO;
    data['SCHEMECODE'] = this.sCHEMECODE;
    data['SCHEME_NAME'] = this.sCHEMENAME;
    data['AMC_CODE'] = this.aMCCODE;
    data['AMC'] = this.aMC;
    data['ASSET_TYPE'] = this.aSSETTYPE;
    data['CATEGORY_CODE'] = this.cATEGORYCODE;
    data['CATEGORY_NAME'] = this.cATEGORYNAME;
    data['RISK'] = this.rISK;
    data['NAVDATE'] = this.nAVDATE;
    data['NAV'] = this.nAV;
    data['CHANGE'] = this.cHANGE;
    data['CHANGE_PERC'] = this.cHANGEPERC;
    data['1MONTHRET'] = this.s1MONTHRET;
    data['3MONTHRET'] = this.s3MONTHRET;
    data['6MONTHRET'] = this.s6MONTHRET;
    data['1YRRET'] = this.s1YRRET;
    data['3YEARRET'] = this.s3YEARRET;
    data['5YEARRET'] = this.s5YEARRET;
    data['INCRET'] = this.iNCRET;
    return data;
  }
}

class Table1 {
  String? totalRecords;

  Table1({this.totalRecords});

  Table1.fromJson(Map<String, dynamic> json) {
    totalRecords = json['TotalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRecords'] = this.totalRecords;
    return data;
  }
}
