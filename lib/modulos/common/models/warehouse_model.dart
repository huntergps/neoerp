import 'dart:convert';

class WarehouseIdData {
  int? writeUid;
  int? createUid;
  String? writeDate;
  String? code;
  int? id;
  String? name;
  String? createDate;
  bool? active;

  WarehouseIdData(
      {this.writeUid,
      this.createUid,
      this.writeDate,
      this.code,
      this.id,
      this.name,
      this.createDate,
      this.active});

  Map<String, dynamic> toMap() {
    return {
      'writeUid': writeUid,
      'createUid': createUid,
      'writeDate': writeDate,
      'code': code,
      'id': id,
      'name': name,
      'createDate': createDate,
      'active': active,
    };
  }

  factory WarehouseIdData.fromMap(Map<String, dynamic> map) {
    return WarehouseIdData(
      writeUid: map['writeUid']?.toInt(),
      createUid: map['createUid']?.toInt(),
      writeDate: map['writeDate'],
      code: map['code'],
      id: map['id']?.toInt(),
      name: map['name'],
      createDate: map['createDate'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehouseIdData.fromJson(String source) =>
      WarehouseIdData.fromMap(json.decode(source));
}
