import 'dart:convert';

class ProductUomData {
  int? writeUid;
  int? createUid;
  String? writeDate;
  int? factor;
  int? id;
  String? name;
  String? createDate;
  bool? active;

  ProductUomData(
      {this.writeUid,
      this.createUid,
      this.writeDate,
      this.factor,
      this.id,
      this.name,
      this.createDate,
      this.active});

  Map<String, dynamic> toMap() {
    return {
      'writeUid': writeUid,
      'createUid': createUid,
      'writeDate': writeDate,
      'factor': factor,
      'id': id,
      'name': name,
      'createDate': createDate,
      'active': active,
    };
  }

  factory ProductUomData.fromMap(Map<String, dynamic> map) {
    return ProductUomData(
      writeUid: map['writeUid']?.toInt(),
      createUid: map['createUid']?.toInt(),
      writeDate: map['writeDate'],
      factor: map['factor']?.toInt(),
      id: map['id']?.toInt(),
      name: map['name'],
      createDate: map['createDate'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductUomData.fromJson(String source) =>
      ProductUomData.fromMap(json.decode(source));
}
