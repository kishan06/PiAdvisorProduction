
class HoldingModel {
  final String? quantity;
  final String? averagePrice;
  final String? transactableQuantity;
  final String? nseTicker;
  final String? bseTicker;
  final String? isin;
  final String? name;

  const HoldingModel({
     this.quantity,
     this.transactableQuantity,
     this.averagePrice,
     this.nseTicker,
     this.bseTicker,
     this.isin,
     this.name,
  });

  factory HoldingModel.fromJson(Map<String, dynamic> json) {
    // return HoldingModel();
   return HoldingModel(
      quantity: json['holdings']['quantity'].toString(),
      averagePrice: json['holdings']['averagePrice'].toString(),
      transactableQuantity: json['transactableQuantity'].toString(),
      nseTicker: json['nseTicker'] as String?,
      bseTicker: json['bseTicker'] as String?,
      isin: json['isin'] as String?,
      name: json['name'] as String?,
    );
  }
}
