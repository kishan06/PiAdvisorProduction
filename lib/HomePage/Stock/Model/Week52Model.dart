class Week52Model {
  List<Table>? table;
  List<Table1>? table1;

  Week52Model({this.table, this.table1});

  Week52Model.fromJson(Map<String, dynamic> json) {
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
  String? cOMPNAME;
  String? sNAME;
  String? sCRIPGROUP;
  String? lastPrice;
  String? todaysHighLow;
  String? optioHighLow;
  String? highPrice;
  String? lOWPrice;
  String? hIGHDATE;
  String? lOWDATE;
  String? change;
  String? perChange;
  String? value;
  String? uPDTIME;
  String? volume;
  String? openPrice;

  Table(
      {this.sCRIPCODE,
      this.fINCODE,
      this.sYMBOL,
      this.cOMPNAME,
      this.sNAME,
      this.sCRIPGROUP,
      this.lastPrice,
      this.todaysHighLow,
      this.optioHighLow,
      this.highPrice,
      this.lOWPrice,
      this.hIGHDATE,
      this.lOWDATE,
      this.change,
      this.perChange,
      this.value,
      this.uPDTIME,
      this.volume,
      this.openPrice});

  Table.fromJson(Map<String, dynamic> json) {
    sCRIPCODE = json['SCRIPCODE'];
    fINCODE = json['FINCODE'];
    sYMBOL = json['SYMBOL'];
    cOMPNAME = json['COMPNAME'];
    sNAME = json['S_NAME'];
    sCRIPGROUP = json['SCRIP_GROUP'];
    lastPrice = json['LastPrice'];
    todaysHighLow = json['TodaysHighLow'];
    optioHighLow = json['OptioHighLow'];
    highPrice = json['HighPrice'];
    lOWPrice = json['LOWPrice'];
    hIGHDATE = json['HIGHDATE'];
    lOWDATE = json['LOWDATE'];
    change = json['Change'];
    perChange = json['PerChange'];
    value = json['Value'];
    uPDTIME = json['UPD_TIME'];
    volume = json['Volume'];
    openPrice = json['OpenPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCRIPCODE'] = this.sCRIPCODE;
    data['FINCODE'] = this.fINCODE;
    data['SYMBOL'] = this.sYMBOL;
    data['COMPNAME'] = this.cOMPNAME;
    data['S_NAME'] = this.sNAME;
    data['SCRIP_GROUP'] = this.sCRIPGROUP;
    data['LastPrice'] = this.lastPrice;
    data['TodaysHighLow'] = this.todaysHighLow;
    data['OptioHighLow'] = this.optioHighLow;
    data['HighPrice'] = this.highPrice;
    data['LOWPrice'] = this.lOWPrice;
    data['HIGHDATE'] = this.hIGHDATE;
    data['LOWDATE'] = this.lOWDATE;
    data['Change'] = this.change;
    data['PerChange'] = this.perChange;
    data['Value'] = this.value;
    data['UPD_TIME'] = this.uPDTIME;
    data['Volume'] = this.volume;
    data['OpenPrice'] = this.openPrice;
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
