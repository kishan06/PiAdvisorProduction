class BrokerAccountModel {
  final String? id;
  final String? userId;
  final String? brokerName;
  final String? authToken;
  final String? txnId;

  const BrokerAccountModel({
    required this.id,
    required this.userId,
    required this.brokerName,
    required this.authToken,
    required this.txnId,
  });

  factory BrokerAccountModel.fromJson(Map<String, dynamic> json) {
    return BrokerAccountModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      brokerName: json['broker_name'] as String?,
      authToken: json['auth_token'] as String?,
      txnId: json['transaction_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['broker_name'] = brokerName;
    data['auth_token'] = authToken;
    data['transaction_id'] = txnId;
    return data;
  }
}
