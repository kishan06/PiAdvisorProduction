class PriceChartModel {
  List<Table>? table;
  List<Table1>? table1;

  PriceChartModel({this.table, this.table1});

  PriceChartModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? price;
  String? open;
  String? high;
  String? low;
  String? volume;
  String? pe;

  Table(
      {this.date,
      this.price,
      this.open,
      this.high,
      this.low,
      this.volume,
      this.pe});

  Table.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    price = json['price'];
    open = json['Open'];
    high = json['high'];
    low = json['low'];
    volume = json['volume'];
    pe = json['pe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['price'] = this.price;
    data['Open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['volume'] = this.volume;
    data['pe'] = this.pe;
    return data;
  }
}

class Table1 {
  String? prevClose;

  Table1({this.prevClose});

  Table1.fromJson(Map<String, dynamic> json) {
    prevClose = json['Prev_Close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Prev_Close'] = this.prevClose;
    return data;
  }
}
