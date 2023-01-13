class SearchStocksModel {
  List<Table>? table;

  SearchStocksModel({this.table});

  SearchStocksModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  String? fINCODE;
  String? sCRIPCODE;
  String? sYMBOL;
  String? compname;
  String? sName;
  String? iSIN;

  Table(
      {this.fINCODE,
      this.sCRIPCODE,
      this.sYMBOL,
      this.compname,
      this.sName,
      this.iSIN});

  Table.fromJson(Map<String, dynamic> json) {
    fINCODE = json['FINCODE'];
    sCRIPCODE = json['SCRIPCODE'];
    sYMBOL = json['SYMBOL'];
    compname = json['compname'];
    sName = json['S_Name'];
    iSIN = json['ISIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FINCODE'] = this.fINCODE;
    data['SCRIPCODE'] = this.sCRIPCODE;
    data['SYMBOL'] = this.sYMBOL;
    data['compname'] = this.compname;
    data['S_Name'] = this.sName;
    data['ISIN'] = this.iSIN;
    return data;
  }
}
