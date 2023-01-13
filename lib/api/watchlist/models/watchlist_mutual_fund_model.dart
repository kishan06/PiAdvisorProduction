class WatchlistMutualFundModel {
  final int id;
  final int userId;
  final String companyName;
  final String schemeCode;

  const WatchlistMutualFundModel({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.schemeCode,
  });

  factory WatchlistMutualFundModel.fromJson(Map<String, dynamic> json) =>
      WatchlistMutualFundModel(
        id: json['id'],
        userId: json['user_id'],
        companyName: json['company_funding_name'],
        schemeCode: json['option_scheme'],
      );
}
