class slotModel {
  Status? status;

  slotModel({this.status});

  slotModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  int? slot1;
  int? slot2;
  int? slot3;
  int? slot4;
  int? slot5;
  int? slot6;
  int? slot7;
  int? slot8;
  int? slot9;
  int? slot10;
  int? slot11;
  int? slot12;
  int? slot13;
  int? slot14;
  int? slot15;
  int? slot16;
  int? slot17;
  int? slot18;
  int? slot19;
  int? slot20;
  int? slot21;
  int? slot22;
  int? slot23;
  int? slot24;
  int? slot25;
  int? slot26;
  int? slot27;
  Null? createdAt;
  Null? updatedAt;

  Status(
      {this.id,
      this.date,
      this.slot1,
      this.slot2,
      this.slot3,
      this.slot4,
      this.slot5,
      this.slot6,
      this.slot7,
      this.slot8,
      this.slot9,
      this.slot10,
      this.slot11,
      this.slot12,
      this.slot13,
      this.slot14,
      this.slot15,
      this.slot16,
      this.slot17,
      this.slot18,
      this.slot19,
      this.slot20,
      this.slot21,
      this.slot22,
      this.slot23,
      this.slot24,
      this.slot25,
      this.slot26,
      this.slot27,
      this.createdAt,
      this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['Date'];
    slot1 = json['slot1'];
    slot2 = json['slot2'];
    slot3 = json['slot3'];
    slot4 = json['slot4'];
    slot5 = json['slot5'];
    slot6 = json['slot6'];
    slot7 = json['slot7'];
    slot8 = json['slot8'];
    slot9 = json['slot9'];
    slot10 = json['slot10'];
    slot11 = json['slot11'];
    slot12 = json['slot12'];
    slot13 = json['slot13'];
    slot14 = json['slot14'];
    slot15 = json['slot15'];
    slot16 = json['slot16'];
    slot17 = json['slot17'];
    slot18 = json['slot18'];
    slot19 = json['slot19'];
    slot20 = json['slot20'];
    slot21 = json['slot21'];
    slot22 = json['slot22'];
    slot23 = json['slot23'];
    slot24 = json['slot24'];
    slot25 = json['slot25'];
    slot26 = json['slot26'];
    slot27 = json['slot27'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Date'] = this.date;
    data['slot1'] = this.slot1;
    data['slot2'] = this.slot2;
    data['slot3'] = this.slot3;
    data['slot4'] = this.slot4;
    data['slot5'] = this.slot5;
    data['slot6'] = this.slot6;
    data['slot7'] = this.slot7;
    data['slot8'] = this.slot8;
    data['slot9'] = this.slot9;
    data['slot10'] = this.slot10;
    data['slot11'] = this.slot11;
    data['slot12'] = this.slot12;
    data['slot13'] = this.slot13;
    data['slot14'] = this.slot14;
    data['slot15'] = this.slot15;
    data['slot16'] = this.slot16;
    data['slot17'] = this.slot17;
    data['slot18'] = this.slot18;
    data['slot19'] = this.slot19;
    data['slot20'] = this.slot20;
    data['slot21'] = this.slot21;
    data['slot22'] = this.slot22;
    data['slot23'] = this.slot23;
    data['slot24'] = this.slot24;
    data['slot25'] = this.slot25;
    data['slot26'] = this.slot26;
    data['slot27'] = this.slot27;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
