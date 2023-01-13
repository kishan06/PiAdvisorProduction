class IntradayPriceChartModel {
  List<Table>? table;
  List<Table1>? table1;
  List<Table2>? table2;

  IntradayPriceChartModel({this.table, this.table1, this.table2});

  IntradayPriceChartModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  String? price;
  String? open;
  String? high;
  String? low;
  String? volume;

  Table({this.date, this.price, this.open, this.high, this.low, this.volume});

  Table.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    price = json['price'];
    open = json['Open'];
    high = json['high'];
    low = json['low'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['price'] = this.price;
    data['Open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['volume'] = this.volume;
    return data;
  }
}

class Table1 {
  String? maxClose;
  String? minClose;

  Table1({this.maxClose, this.minClose});

  Table1.fromJson(Map<String, dynamic> json) {
    maxClose = json['MaxClose'];
    minClose = json['MinClose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MaxClose'] = this.maxClose;
    data['MinClose'] = this.minClose;
    return data;
  }
}

class Table2 {
  String? prevClose;

  Table2({this.prevClose});

  Table2.fromJson(Map<String, dynamic> json) {
    prevClose = json['Prev_Close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Prev_Close'] = this.prevClose;
    return data;
  }
}
