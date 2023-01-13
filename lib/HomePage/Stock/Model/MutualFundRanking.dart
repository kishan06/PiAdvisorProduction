class MutalFundRanking {
  List<Table>? table;
  List<Table1>? table1;
  List<Table2>? table2;

  MutalFundRanking({this.table, this.table1, this.table2});

  MutalFundRanking.fromJson(Map<String, dynamic> json) {
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
    if (json['Table2'] != null) {
      table2 = <Table2>[];
      json['Table2'].forEach((v) {
        table2!.add(new Table2.fromJson(v));
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
    if (this.table2 != null) {
      data['Table2'] = this.table2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  String? aSonDate;

  Table({this.aSonDate});

  Table.fromJson(Map<String, dynamic> json) {
    aSonDate = json['ASonDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ASonDate'] = this.aSonDate;
    return data;
  }
}

class Table1 {
  String? srno;
  String? typeCode;
  String? optCode;
  String? sCHEMECODE;
  String? sNAME;
  String? mOBNAME;
  String? nAVRS;
  String? iNCDate;
  String? s1WEEKRET;
  String? s1MONTHRET;
  String? s3MONTHRET;
  String? s6MONTHRET;
  String? s1YEARRET;
  String? s2YEARRET;
  String? s3YEARRET;
  String? s5YEARRET;
  String? iNCRET;
  String? aMCCODE;
  String? cATEGORYCODE;
  String? fundRank;
  String? returns;

  Table1(
      {this.srno,
      this.typeCode,
      this.optCode,
      this.sCHEMECODE,
      this.sNAME,
      this.mOBNAME,
      this.nAVRS,
      this.iNCDate,
      this.s1WEEKRET,
      this.s1MONTHRET,
      this.s3MONTHRET,
      this.s6MONTHRET,
      this.s1YEARRET,
      this.s2YEARRET,
      this.s3YEARRET,
      this.s5YEARRET,
      this.iNCRET,
      this.aMCCODE,
      this.cATEGORYCODE,
      this.fundRank,
      this.returns});

  Table1.fromJson(Map<String, dynamic> json) {
    srno = json['srno'];
    typeCode = json['type_code'];
    optCode = json['Opt_code'];
    sCHEMECODE = json['SCHEMECODE'];
    sNAME = json['S_NAME'];
    mOBNAME = json['MOB_NAME'];
    nAVRS = json['NAVRS'];
    iNCDate = json['INCDate'];
    s1WEEKRET = json['1WEEKRET'];
    s1MONTHRET = json['1MONTHRET'];
    s3MONTHRET = json['3MONTHRET'];
    s6MONTHRET = json['6MONTHRET'];
    s1YEARRET = json['1YEARRET'];
    s2YEARRET = json['2YEARRET'];
    s3YEARRET = json['3YEARRET'];
    s5YEARRET = json['5YEARRET'];
    iNCRET = json['INCRET'];
    aMCCODE = json['AMC_CODE'];
    cATEGORYCODE = json['CATEGORYCODE'];
    fundRank = json['FundRank'];
    returns = json['Return'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['srno'] = this.srno;
    data['type_code'] = this.typeCode;
    data['Opt_code'] = this.optCode;
    data['SCHEMECODE'] = this.sCHEMECODE;
    data['S_NAME'] = this.sNAME;
    data['MOB_NAME'] = this.mOBNAME;
    data['NAVRS'] = this.nAVRS;
    data['INCDate'] = this.iNCDate;
    data['1WEEKRET'] = this.s1WEEKRET;
    data['1MONTHRET'] = this.s1MONTHRET;
    data['3MONTHRET'] = this.s3MONTHRET;
    data['6MONTHRET'] = this.s6MONTHRET;
    data['1YEARRET'] = this.s1YEARRET;
    data['2YEARRET'] = this.s2YEARRET;
    data['3YEARRET'] = this.s3YEARRET;
    data['5YEARRET'] = this.s5YEARRET;
    data['INCRET'] = this.iNCRET;
    data['AMC_CODE'] = this.aMCCODE;
    data['CATEGORYCODE'] = this.cATEGORYCODE;
    data['FundRank'] = this.fundRank;
    data['Return'] = this.returns;
    return data;
  }
}

class Table2 {
  String? totalRows;

  Table2({this.totalRows});

  Table2.fromJson(Map<String, dynamic> json) {
    totalRows = json['TotalRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRows'] = this.totalRows;
    return data;
  }
}
