class OnlyBuyersModel {
  List<Table>? table;
  List<Table1>? table1;

  OnlyBuyersModel({this.table, this.table1});

  OnlyBuyersModel.fromJson(Map<String, dynamic> json) {
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
  String? sYMBOL;
  String? fINCODE;
  String? sNAME;
  String? sCRIPGROUP;
  String? bidOfferQty;
  String? lastPrice;
  String? prevClose;
  String? chng;
  String? perChng;
  String? volume;

  Table(
      {this.sCRIPCODE,
      this.sYMBOL,
      this.fINCODE,
      this.sNAME,
      this.sCRIPGROUP,
      this.bidOfferQty,
      this.lastPrice,
      this.prevClose,
      this.chng,
      this.perChng,
      this.volume});

  Table.fromJson(Map<String, dynamic> json) {
    sCRIPCODE = json['SCRIPCODE'];
    sYMBOL = json['SYMBOL'];
    fINCODE = json['FINCODE'];
    sNAME = json['S_NAME'];
    sCRIPGROUP = json['SCRIP_GROUP'];
    bidOfferQty = json['BidOfferQty'];
    lastPrice = json['LastPrice'];
    prevClose = json['PrevClose'];
    chng = json['Chng'];
    perChng = json['PerChng'];
    volume = json['Volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCRIPCODE'] = this.sCRIPCODE;
    data['SYMBOL'] = this.sYMBOL;
    data['FINCODE'] = this.fINCODE;
    data['S_NAME'] = this.sNAME;
    data['SCRIP_GROUP'] = this.sCRIPGROUP;
    data['BidOfferQty'] = this.bidOfferQty;
    data['LastPrice'] = this.lastPrice;
    data['PrevClose'] = this.prevClose;
    data['Chng'] = this.chng;
    data['PerChng'] = this.perChng;
    data['Volume'] = this.volume;
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
