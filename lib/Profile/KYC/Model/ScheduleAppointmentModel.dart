class ScheduleAppointmentModel {
  List<RequestedData>? requestedData;
  List<ScheduleData>? scheduleData;
  List<PastData>? pastData;

  ScheduleAppointmentModel(
      {this.requestedData, this.scheduleData, this.pastData});

  ScheduleAppointmentModel.fromJson(Map<String, dynamic> json) {
    if (json['requestedData'] != null) {
      requestedData = <RequestedData>[];
      json['requestedData'].forEach((v) {
        requestedData!.add(new RequestedData.fromJson(v));
      });
    }
    if (json['scheduleData'] != null) {
      scheduleData = <ScheduleData>[];
      json['scheduleData'].forEach((v) {
        scheduleData!.add(new ScheduleData.fromJson(v));
      });
    }
    if (json['pastData'] != null) {
      pastData = <PastData>[];
      json['pastData'].forEach((v) {
        pastData!.add(new PastData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestedData != null) {
      data['requestedData'] =
          this.requestedData!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleData != null) {
      data['scheduleData'] = this.scheduleData!.map((v) => v.toJson()).toList();
    }
    if (this.pastData != null) {
      data['pastData'] = this.pastData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestedData {
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
  UserData? userData;

  RequestedData(
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
      this.updatedAt,
      this.userData});

  RequestedData.fromJson(Map<String, dynamic> json) {
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
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
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
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}

class PastData {
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
  UserData? userData;

  PastData(
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
      this.updatedAt,
      this.userData});

  PastData.fromJson(Map<String, dynamic> json) {
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
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
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
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}

class ScheduleData {
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
  UserData? userData;

  ScheduleData(
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
      this.updatedAt,
      this.userData});

  ScheduleData.fromJson(Map<String, dynamic> json) {
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
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
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
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
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

class UserData {
  String? fullName;
  String? email;

  UserData({this.fullName, this.email});

  UserData.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    return data;
  }
}
