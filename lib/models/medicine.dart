import 'dart:ui';

class Medicine {
  int? id;
  String? name;
  String? dosage;
  String? dosageType;
  String? hour;
  String? date;
  String? image;

  Medicine({
    this.dosage,
    this.name,
    this.hour,
    this.date,
    this.image,
    this.dosageType,
  });
  Medicine.withId({
    this.dosage,
    this.id,
    this.name,
    this.hour,
    this.image,
    this.date,
    this.dosageType,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["dosage"] = dosage;
    map["dosageType"] = dosageType;
    map["hour"] = hour;
    map["date"] = date;
    map["image"] = image;

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Medicine.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"].toString());
    this.name = o["name"];
    this.dosage = o["dosage"];
    this.dosageType = o["dosageType"];
    this.hour = o["hour"];
    this.date = o["date"];
    this.image = o["image"];
  }
}
