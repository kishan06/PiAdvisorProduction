class appointment {
  List<Status>? status;

  appointment({this.status});

  appointment.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = <Status>[];
      json['status'].forEach((v) {
        status!.add(new Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  int? id;
  int? userId;
  String? date;
  String? timeSlot;
  String? link;
  String? advisory;
  String? dateTimeslot;
  int? subscriptionId;
  String? createdAt;
  String? updatedAt;

  Status(
      {this.id,
      this.userId,
      this.date,
      this.timeSlot,
      this.link,
      this.advisory,
      this.dateTimeslot,
      this.subscriptionId,
      this.createdAt,
      this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['Date'];
    timeSlot = json['timeSlot'];
    link = json['link'];
    advisory = json['advisory'];
    dateTimeslot = json['date_timeslot'];
    subscriptionId = json['subscription_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['Date'] = this.date;
    data['timeSlot'] = this.timeSlot;
    data['link'] = this.link;
    data['advisory'] = this.advisory;
    data['date_timeslot'] = this.dateTimeslot;
    data['subscription_id'] = this.subscriptionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
