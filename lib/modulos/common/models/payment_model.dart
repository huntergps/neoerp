import 'dart:convert';

class PaymentTermIdData {
  int? id;
  String? name;
  bool? isCashSale;
  bool? active;
  String? createDate;
  String? writeDate;
  int? writeUid;
  int? createUid;

  PaymentTermIdData({
    this.id,
    this.name,
    this.isCashSale,
    this.active,
    this.createDate,
    this.writeDate,
    this.writeUid,
    this.createUid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isCashSale': isCashSale,
      'active': active,
      'createDate': createDate,
      'writeDate': writeDate,
      'writeUid': writeUid,
      'createUid': createUid,
    };
  }

  factory PaymentTermIdData.fromMap(Map<String, dynamic> map) {
    return PaymentTermIdData(
      id: map['id']?.toInt(),
      name: map['name'],
      isCashSale: map['is_cash_sale'],
      active: map['active'],
      createDate: map['create_date'],
      writeDate: map['write_date'],
      writeUid: map['write_uid']?.toInt(),
      createUid: map['create_uid']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTermIdData.fromJson(String source) =>
      PaymentTermIdData.fromMap(json.decode(source));
}
