class AppointmentsByDate {
  Status? status;

  AppointmentsByDate({this.status});

  AppointmentsByDate.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
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
  Guests? guests;
  String? advisory;
  String? dateTimeslot;
  int? subscriptionId;
  int? status;
  String? file;
  String? meetingId;
  String? subject;
  String? message;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Status(
      {this.id,
      this.userId,
      this.date,
      this.timeSlot,
      this.link,
      this.guests,
      this.advisory,
      this.dateTimeslot,
      this.subscriptionId,
      this.status,
      this.file,
      this.meetingId,
      this.subject,
      this.message,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['Date'];
    timeSlot = json['timeSlot'];
    link = json['link'];
    guests =
        json['guests'] != null ? new Guests.fromJson(json['guests']) : null;
    advisory = json['advisory'];
    dateTimeslot = json['date_timeslot'];
    subscriptionId = json['subscription_id'];
    status = json['status'];
    file = json['file'];
    meetingId = json['meeting_id'];
    subject = json['subject'];
    message = json['message'];
    isActive = json['is_active'];
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
    if (this.guests != null) {
      data['guests'] = this.guests!.toJson();
    }
    data['advisory'] = this.advisory;
    data['date_timeslot'] = this.dateTimeslot;
    data['subscription_id'] = this.subscriptionId;
    data['status'] = this.status;
    data['file'] = this.file;
    data['meeting_id'] = this.meetingId;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Guests {
  String? guestName;
  String? guestEmail;

  Guests({this.guestName, this.guestEmail});

  Guests.fromJson(Map<String, dynamic> json) {
    guestName = json['guest_name'];
    guestEmail = json['guest_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guest_name'] = this.guestName;
    data['guest_email'] = this.guestEmail;
    return data;
  }
}
