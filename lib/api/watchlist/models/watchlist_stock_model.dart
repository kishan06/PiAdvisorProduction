class WatchlistStockModel {
  final int id;
  final int userId;
  final String companyName;
  final String tickerCode;
  final String fincode;

  const WatchlistStockModel({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.tickerCode,
    required this.fincode,
  });

  factory WatchlistStockModel.fromJson(Map<String, dynamic> json) =>
      WatchlistStockModel(
        id: json['id'],
        userId: json['user_id'],
        companyName: json['company_name'],
        tickerCode: json['ticker_code'],
        fincode: json['fin_code'],
      );
}
