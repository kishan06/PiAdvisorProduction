class RiskAnswers {
  String? status;
  List<Data>? data;

  RiskAnswers({this.status, this.data});

  RiskAnswers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? questionId;
  int? answerid;
  int? score;
  int? totalScore;
  String? createdAt;
  String? updatedAt;
  RiskAnswerMaster? riskAnswerMaster;

  Data(
      {this.id,
      this.userId,
      this.questionId,
      this.answerid,
      this.score,
      this.totalScore,
      this.createdAt,
      this.updatedAt,
      this.riskAnswerMaster});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    questionId = json['questionId'];
    answerid = json['answerid'];
    score = json['score'];
    totalScore = json['total_score'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    riskAnswerMaster = json['risk_answer_master'] != null
        ? new RiskAnswerMaster.fromJson(json['risk_answer_master'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['questionId'] = this.questionId;
    data['answerid'] = this.answerid;
    data['score'] = this.score;
    data['total_score'] = this.totalScore;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.riskAnswerMaster != null) {
      data['risk_answer_master'] = this.riskAnswerMaster!.toJson();
    }
    return data;
  }
}

class RiskAnswerMaster {
  int? id;
  int? questionId;
  String? answer;
  int? score;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  RiskAnswerMaster(
      {this.id,
      this.questionId,
      this.answer,
      this.score,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  RiskAnswerMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['questionId'];
    answer = json['answer'];
    score = json['score'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questionId'] = this.questionId;
    data['answer'] = this.answer;
    data['score'] = this.score;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
