class TopGainersLosers {
  List<Table>? table;
  List<Table1>? table1;
  List<Table2>? table2;

  TopGainersLosers({this.table, this.table1, this.table2});

  TopGainersLosers.fromJson(Map<String, dynamic> json) {
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
  String? sTKEXCHANGE;
  String? sCRIPCODE;
  String? fINCODE;
  String? sYMBOL;
  String? cOMPNAME;
  String? sNAME;
  String? sCRIPGROUP;
  String? uPDTIME;
  String? oPENPRICE;
  String? hIGHPRICE;
  String? lOWPRICE;
  String? cLOSEPRICE;
  String? bIDQTY;
  String? bIDPRICE;
  String? oFFERQTY;
  String? oFFERPRICE;
  String? pREVCLOSE;
  String? pERCHG;
  String? nETCHG;
  String? vOLUME;
  String? vALUE;
  String? pREVDATE;
  String? mCAP;

  Table(
      {this.sTKEXCHANGE,
      this.sCRIPCODE,
      this.fINCODE,
      this.sYMBOL,
      this.cOMPNAME,
      this.sNAME,
      this.sCRIPGROUP,
      this.uPDTIME,
      this.oPENPRICE,
      this.hIGHPRICE,
      this.lOWPRICE,
      this.cLOSEPRICE,
      this.bIDQTY,
      this.bIDPRICE,
      this.oFFERQTY,
      this.oFFERPRICE,
      this.pREVCLOSE,
      this.pERCHG,
      this.nETCHG,
      this.vOLUME,
      this.vALUE,
      this.pREVDATE,
      this.mCAP});

  Table.fromJson(Map<String, dynamic> json) {
    sTKEXCHANGE = json['STK_EXCHANGE'];
    sCRIPCODE = json['SCRIPCODE'];
    fINCODE = json['FINCODE'];
    sYMBOL = json['SYMBOL'];
    cOMPNAME = json['COMPNAME'];
    sNAME = json['S_NAME'];
    sCRIPGROUP = json['SCRIP_GROUP'];
    uPDTIME = json['UPD_TIME'];
    oPENPRICE = json['OPEN_PRICE'];
    hIGHPRICE = json['HIGH_PRICE'];
    lOWPRICE = json['LOW_PRICE'];
    cLOSEPRICE = json['CLOSE_PRICE'];
    bIDQTY = json['BIDQTY'];
    bIDPRICE = json['BIDPRICE'];
    oFFERQTY = json['OFFERQTY'];
    oFFERPRICE = json['OFFERPRICE'];
    pREVCLOSE = json['PREVCLOSE'];
    pERCHG = json['PERCHG'];
    nETCHG = json['NETCHG'];
    vOLUME = json['VOLUME'];
    vALUE = json['VALUE'];
    pREVDATE = json['PREV_DATE'];
    mCAP = json['MCAP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STK_EXCHANGE'] = this.sTKEXCHANGE;
    data['SCRIPCODE'] = this.sCRIPCODE;
    data['FINCODE'] = this.fINCODE;
    data['SYMBOL'] = this.sYMBOL;
    data['COMPNAME'] = this.cOMPNAME;
    data['S_NAME'] = this.sNAME;
    data['SCRIP_GROUP'] = this.sCRIPGROUP;
    data['UPD_TIME'] = this.uPDTIME;
    data['OPEN_PRICE'] = this.oPENPRICE;
    data['HIGH_PRICE'] = this.hIGHPRICE;
    data['LOW_PRICE'] = this.lOWPRICE;
    data['CLOSE_PRICE'] = this.cLOSEPRICE;
    data['BIDQTY'] = this.bIDQTY;
    data['BIDPRICE'] = this.bIDPRICE;
    data['OFFERQTY'] = this.oFFERQTY;
    data['OFFERPRICE'] = this.oFFERPRICE;
    data['PREVCLOSE'] = this.pREVCLOSE;
    data['PERCHG'] = this.pERCHG;
    data['NETCHG'] = this.nETCHG;
    data['VOLUME'] = this.vOLUME;
    data['VALUE'] = this.vALUE;
    data['PREV_DATE'] = this.pREVDATE;
    data['MCAP'] = this.mCAP;
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

class Table2 {
  String? uPDTIME;

  Table2({this.uPDTIME});

  Table2.fromJson(Map<String, dynamic> json) {
    uPDTIME = json['UPD_TIME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UPD_TIME'] = this.uPDTIME;
    return data;
  }
}
