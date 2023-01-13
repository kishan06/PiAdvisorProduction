class FAQ {
  List<Cat1>? cat1;
  List<Cat2>? cat2;
  List<Cat3>? cat3;
  List<Cat4>? cat4;

  FAQ({this.cat1, this.cat2, this.cat3, this.cat4});

  FAQ.fromJson(Map<String, dynamic> json) {
    if (json['cat1'] != null) {
      cat1 = <Cat1>[];
      json['cat1'].forEach((v) {
        cat1!.add(new Cat1.fromJson(v));
      });
    }
    if (json['cat2'] != null) {
      cat2 = <Cat2>[];
      json['cat2'].forEach((v) {
        cat2!.add(new Cat2.fromJson(v));
      });
    }
    if (json['cat3'] != null) {
      cat3 = <Cat3>[];
      json['cat3'].forEach((v) {
        cat3!.add(new Cat3.fromJson(v));
      });
    }
    if (json['cat4'] != null) {
      cat4 = <Cat4>[];
      json['cat4'].forEach((v) {
        cat4!.add(new Cat4.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cat1 != null) {
      data['cat1'] = this.cat1!.map((v) => v.toJson()).toList();
    }
    if (this.cat2 != null) {
      data['cat2'] = this.cat2!.map((v) => v.toJson()).toList();
    }
    if (this.cat3 != null) {
      data['cat3'] = this.cat3!.map((v) => v.toJson()).toList();
    }
    if (this.cat4 != null) {
      data['cat4'] = this.cat4!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cat1 {
  int? id;
  int? catId;
  String? questions;
  String? answers;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Cat1(
      {this.id,
      this.catId,
      this.questions,
      this.answers,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Cat1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    questions = json['questions'];
    answers = json['answers'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['questions'] = this.questions;
    data['answers'] = this.answers;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Cat2 {
  int? id;
  int? catId;
  String? questions;
  String? answers;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Cat2(
      {this.id,
      this.catId,
      this.questions,
      this.answers,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Cat2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    questions = json['questions'];
    answers = json['answers'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['questions'] = this.questions;
    data['answers'] = this.answers;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Cat3 {
  int? id;
  int? catId;
  String? questions;
  String? answers;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Cat3(
      {this.id,
      this.catId,
      this.questions,
      this.answers,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Cat3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    questions = json['questions'];
    answers = json['answers'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['questions'] = this.questions;
    data['answers'] = this.answers;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Cat4 {
  int? id;
  int? catId;
  String? questions;
  String? answers;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Cat4(
      {this.id,
      this.catId,
      this.questions,
      this.answers,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Cat4.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    questions = json['questions'];
    answers = json['answers'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['questions'] = this.questions;
    data['answers'] = this.answers;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
