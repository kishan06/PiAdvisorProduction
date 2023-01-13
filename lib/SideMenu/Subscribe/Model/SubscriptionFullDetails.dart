class SubscriptionFullDetails {
  String? message;
  List<Data>? data;

  SubscriptionFullDetails({this.message, this.data});

  SubscriptionFullDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? planId;
  int? transactionId;
  String? planEndDate;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  Transaction? transaction;
  Plan? plan;

  Data(
      {this.id,
      this.userId,
      this.planId,
      this.transactionId,
      this.planEndDate,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.transaction,
      this.plan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    transactionId = json['transaction_id'];
    planEndDate = json['planEndDate'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['plan_id'] = this.planId;
    data['transaction_id'] = this.transactionId;
    data['planEndDate'] = this.planEndDate;
    data['isActive'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    return data;
  }
}

class Transaction {
  int? id;
  int? userId;
  String? paymentId;
  int? amount;
  String? currency;
  String? status;
  String? orderId;
  String? invoiceId;
  int? subscriptionId;
  String? paymentMethod;
  String? amountRefunded;
  String? refundStatus;
  String? captured;
  String? description;
  String? bank;
  String? wallet;
  String? vpa;
  String? errorCode;
  String? errorDescription;
  String? errorSource;
  String? errorStep;
  String? errorReason;
  int? isSuccess;
  String? reason;
  String? createdAt;
  String? updatedAt;

  Transaction(
      {this.id,
      this.userId,
      this.paymentId,
      this.amount,
      this.currency,
      this.status,
      this.orderId,
      this.invoiceId,
      this.subscriptionId,
      this.paymentMethod,
      this.amountRefunded,
      this.refundStatus,
      this.captured,
      this.description,
      this.bank,
      this.wallet,
      this.vpa,
      this.errorCode,
      this.errorDescription,
      this.errorSource,
      this.errorStep,
      this.errorReason,
      this.isSuccess,
      this.reason,
      this.createdAt,
      this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paymentId = json['paymentId'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    orderId = json['order_id'];
    invoiceId = json['invoice_id'];
    subscriptionId = json['subscription_id'];
    paymentMethod = json['payment_method'];
    amountRefunded = json['amount_refunded'];
    refundStatus = json['refund_status'];
    captured = json['captured'];
    description = json['description'];
    bank = json['bank'];
    wallet = json['wallet'];
    vpa = json['vpa'];
    errorCode = json['error_code'];
    errorDescription = json['error_description'];
    errorSource = json['error_source'];
    errorStep = json['error_step'];
    errorReason = json['error_reason'];
    isSuccess = json['isSuccess'];
    reason = json['reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['paymentId'] = this.paymentId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['order_id'] = this.orderId;
    data['invoice_id'] = this.invoiceId;
    data['subscription_id'] = this.subscriptionId;
    data['payment_method'] = this.paymentMethod;
    data['amount_refunded'] = this.amountRefunded;
    data['refund_status'] = this.refundStatus;
    data['captured'] = this.captured;
    data['description'] = this.description;
    data['bank'] = this.bank;
    data['wallet'] = this.wallet;
    data['vpa'] = this.vpa;
    data['error_code'] = this.errorCode;
    data['error_description'] = this.errorDescription;
    data['error_source'] = this.errorSource;
    data['error_step'] = this.errorStep;
    data['error_reason'] = this.errorReason;
    data['isSuccess'] = this.isSuccess;
    data['reason'] = this.reason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Plan {
  int? id;
  String? planName;
  List<String>? description;
  int? amount;
  int? planValidity;
  int? adminUserId;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Plan(
      {this.id,
      this.planName,
      this.description,
      this.amount,
      this.planValidity,
      this.adminUserId,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['planName'];
    description = json['description'].cast<String>();
    amount = json['amount'];
    planValidity = json['PlanValidity'];
    adminUserId = json['admin_user_id'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['planName'] = this.planName;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['PlanValidity'] = this.planValidity;
    data['admin_user_id'] = this.adminUserId;
    data['isActive'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
