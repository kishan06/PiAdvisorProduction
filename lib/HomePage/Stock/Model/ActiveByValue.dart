class ActiveByValueModel {
  List<Table>? table;
  List<Table1>? table1;

  ActiveByValueModel({this.table, this.table1});

  ActiveByValueModel.fromJson(Map<String, dynamic> json) {
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
  String? sCRIPCODE;
  String? fINCODE;
  String? sYMBOL;
  String? sNAME;
  String? sCRIPGROUP;
  String? price;
  String? prevPrice;
  String? change;
  String? perChange;
  String? volume;
  String? vALUE;
  String? high;
  String? low;
  String? uPDTIME;
  String? pREVDATE;
  String? mCAP;

  Table(
      {this.sCRIPCODE,
      this.fINCODE,
      this.sYMBOL,
      this.sNAME,
      this.sCRIPGROUP,
      this.price,
      this.prevPrice,
      this.change,
      this.perChange,
      this.volume,
      this.vALUE,
      this.high,
      this.low,
      this.uPDTIME,
      this.pREVDATE,
      this.mCAP});

  Table.fromJson(Map<String, dynamic> json) {
    sCRIPCODE = json['SCRIPCODE'];
    fINCODE = json['FINCODE'];
    sYMBOL = json['SYMBOL'];
    sNAME = json['S_NAME'];
    sCRIPGROUP = json['SCRIP_GROUP'];
    price = json['Price'];
    prevPrice = json['PrevPrice'];
    change = json['Change'];
    perChange = json['PerChange'];
    volume = json['Volume'];
    vALUE = json['VALUE'];
    high = json['High'];
    low = json['Low'];
    uPDTIME = json['UPDTIME'];
    pREVDATE = json['PREV_DATE'];
    mCAP = json['MCAP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCRIPCODE'] = this.sCRIPCODE;
    data['FINCODE'] = this.fINCODE;
    data['SYMBOL'] = this.sYMBOL;
    data['S_NAME'] = this.sNAME;
    data['SCRIP_GROUP'] = this.sCRIPGROUP;
    data['Price'] = this.price;
    data['PrevPrice'] = this.prevPrice;
    data['Change'] = this.change;
    data['PerChange'] = this.perChange;
    data['Volume'] = this.volume;
    data['VALUE'] = this.vALUE;
    data['High'] = this.high;
    data['Low'] = this.low;
    data['UPDTIME'] = this.uPDTIME;
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
