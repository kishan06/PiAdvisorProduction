class MutualFundGraphPlotting {
  List<Table>? table;

  MutualFundGraphPlotting({this.table});

  MutualFundGraphPlotting.fromJson(Map<String, dynamic> json) {
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
  String? nAVDATE;
  String? nAVRS;

  Table({this.nAVDATE, this.nAVRS});

  Table.fromJson(Map<String, dynamic> json) {
    nAVDATE = json['NAVDATE'];
    nAVRS = json['NAVRS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NAVDATE'] = this.nAVDATE;
    data['NAVRS'] = this.nAVRS;
    return data;
  }
}
