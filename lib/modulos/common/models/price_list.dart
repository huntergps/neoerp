import 'dart:convert';

class PricelistIdData {
  int? writeUid;
  String? writeDate;
  int? createUid;
  int? id;
  String? createDate;

  PricelistIdData(
      {this.writeUid,
      this.writeDate,
      this.createUid,
      this.id,
      this.createDate});

  Map<String, dynamic> toMap() {
    return {
      'writeUid': writeUid,
      'writeDate': writeDate,
      'createUid': createUid,
      'id': id,
      'createDate': createDate,
    };
  }

  factory PricelistIdData.fromMap(Map<String, dynamic> map) {
    return PricelistIdData(
      writeUid: map['writeUid']?.toInt(),
      writeDate: map['writeDate'],
      createUid: map['createUid']?.toInt(),
      id: map['id']?.toInt(),
      createDate: map['createDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PricelistIdData.fromJson(String source) =>
      PricelistIdData.fromMap(json.decode(source));
}
