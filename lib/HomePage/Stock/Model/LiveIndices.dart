class LiveIndices {
  List<Table>? table;
  List<Table1>? table1;
  List<Table5>? table5;

  LiveIndices({this.table, this.table1, this.table5});

  LiveIndices.fromJson(Map<String, dynamic> json) {
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

    if (json['Table5'] != null) {
      table5 = <Table5>[];
      json['Table5'].forEach((v) {
        table5!.add(new Table5.fromJson(v));
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
    if (this.table5 != null) {
      data['Table5'] = this.table5!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  String? iNDEXID;
  String? iNDEXNAME;
  String? oPEN;
  String? hIGH;
  String? lOW;
  String? cLOSE;
  String? pREVCLOSE;
  String? cHANGE;
  String? pERCHANGE;
  String? yEARLYHIGH;
  String? yEARLYLOW;
  String? uPDTIME;
  String? iNDEXLNAME;

  Table(
      {this.iNDEXID,
      this.iNDEXNAME,
      this.oPEN,
      this.hIGH,
      this.lOW,
      this.cLOSE,
      this.pREVCLOSE,
      this.cHANGE,
      this.pERCHANGE,
      this.yEARLYHIGH,
      this.yEARLYLOW,
      this.uPDTIME,
      this.iNDEXLNAME});

  Table.fromJson(Map<String, dynamic> json) {
    iNDEXID = json['INDEX_ID'];
    iNDEXNAME = json['INDEX_NAME'];
    oPEN = json['OPEN'];
    hIGH = json['HIGH'];
    lOW = json['LOW'];
    cLOSE = json['CLOSE'];
    pREVCLOSE = json['PREV_CLOSE'];
    cHANGE = json['CHANGE'];
    pERCHANGE = json['PER_CHANGE'];
    yEARLYHIGH = json['YEARLYHIGH'];
    yEARLYLOW = json['YEARLYLOW'];
    uPDTIME = json['UPDTIME'];
    iNDEXLNAME = json['INDEX_LNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['INDEX_ID'] = this.iNDEXID;
    data['INDEX_NAME'] = this.iNDEXNAME;
    data['OPEN'] = this.oPEN;
    data['HIGH'] = this.hIGH;
    data['LOW'] = this.lOW;
    data['CLOSE'] = this.cLOSE;
    data['PREV_CLOSE'] = this.pREVCLOSE;
    data['CHANGE'] = this.cHANGE;
    data['PER_CHANGE'] = this.pERCHANGE;
    data['YEARLYHIGH'] = this.yEARLYHIGH;
    data['YEARLYLOW'] = this.yEARLYLOW;
    data['UPDTIME'] = this.uPDTIME;
    data['INDEX_LNAME'] = this.iNDEXLNAME;
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

class Table5 {
  String? date;

  Table5({this.date});

  Table5.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    return data;
  }
}
