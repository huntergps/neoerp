import 'dart:convert';

class ProductIdData {
  int? productTmplId;
  String? tracking;
  int? writeUid;
  String? partNumber;
  int? createUid;
  String? writeDate;
  String? sku;
  String? barcode;
  String? type;
  int? id;
  int? uomId;
  String? name;
  String? defaultCode;
  String? createDate;
  bool? active;

  ProductIdData(
      {this.productTmplId,
      this.tracking,
      this.writeUid,
      this.partNumber,
      this.createUid,
      this.writeDate,
      this.sku,
      this.barcode,
      this.type,
      this.id,
      this.uomId,
      this.name,
      this.defaultCode,
      this.createDate,
      this.active});

  Map<String, dynamic> toMap() {
    return {
      'productTmplId': productTmplId,
      'tracking': tracking,
      'writeUid': writeUid,
      'partNumber': partNumber,
      'createUid': createUid,
      'writeDate': writeDate,
      'sku': sku,
      'barcode': barcode,
      'type': type,
      'id': id,
      'uomId': uomId,
      'name': name,
      'defaultCode': defaultCode,
      'createDate': createDate,
      'active': active,
    };
  }

  factory ProductIdData.fromMap(Map<String, dynamic> map) {
    return ProductIdData(
      productTmplId: map['productTmplId']?.toInt(),
      tracking: map['tracking'],
      writeUid: map['writeUid']?.toInt(),
      partNumber: map['partNumber'],
      createUid: map['createUid']?.toInt(),
      writeDate: map['writeDate'],
      sku: map['sku'],
      barcode: map['barcode'],
      type: map['type'],
      id: map['id']?.toInt(),
      uomId: map['uomId']?.toInt(),
      name: map['name'],
      defaultCode: map['defaultCode'],
      createDate: map['createDate'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductIdData.fromJson(String source) =>
      ProductIdData.fromMap(json.decode(source));
}
