import 'dart:convert';

class AcuerdoIdData {
  int? id;
  String? name;
  String? createDate;
  String? writeDate;
  int? writeUid;
  int? createUid;

  AcuerdoIdData({
    this.id,
    this.name,
    this.createDate,
    this.writeDate,
    this.writeUid,
    this.createUid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'create_date': createDate,
      'write_date': writeDate,
      'write_uid': writeUid,
      'create_uid': createUid,
    };
  }

  factory AcuerdoIdData.fromMap(Map<String, dynamic> map) {
    return AcuerdoIdData(
      id: map['id']?.toInt(),
      name: map['name'],
      createDate: map['createDate'],
      writeDate: map['write_date'],
      writeUid: map['write_uid']?.toInt(),
      createUid: map['create_uid']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AcuerdoIdData.fromJson(String source) =>
      AcuerdoIdData.fromMap(json.decode(source));
}
