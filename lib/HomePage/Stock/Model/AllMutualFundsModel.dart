class AllMutualFundsModel {
  List<MutualTable>? table;

  AllMutualFundsModel({this.table});

  AllMutualFundsModel.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <MutualTable>[];
      json['Table'].forEach((v) {
        table!.add(new MutualTable.fromJson(v));
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

class MutualTable {
  String? sCHEMECODE;
  String? sNAME;

  MutualTable({this.sCHEMECODE, this.sNAME});

  MutualTable.fromJson(Map<String, dynamic> json) {
    sCHEMECODE = json['SCHEMECODE'];
    sNAME = json['S_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SCHEMECODE'] = this.sCHEMECODE;
    data['S_NAME'] = this.sNAME;
    return data;
  }
}
