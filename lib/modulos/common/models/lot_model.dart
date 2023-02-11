import 'dart:convert';

import 'package:neo/modulos/widgets/utils.dart';

class StockLot {
  int? id;
  String? createDate;
  int? createUid;
  String? writeDate;
  int? writeUid;
  String? name;
  String? ref;
  int? productId;
  int? productUomId;
  List<int>? locationIds;

  StockLot({
    this.id,
    this.createDate,
    this.createUid,
    this.writeDate,
    this.writeUid,
    this.name,
    this.ref,
    this.productId,
    this.productUomId,
    this.locationIds,
  });

  bool isEqual(StockLot model) {
    return id == model.id;
  }

  @override
  String toString() {
    return name.toString();
  }

// fieldsSeries =['name','ref','product_id','product_uom_id']

  factory StockLot.fromMap(Map<String, dynamic> map) {
    return StockLot(
      id: revisaVaciosInt(map['id']),
      createDate: map['create_date'],
      createUid: revisaVaciosInt(map['create_uid']),
      writeDate: map['write_date'],
      writeUid: revisaVaciosInt(map['write_uid']),
      name: map['name'],
      ref: map['ref'],
      productId: map['partnerId']?.toInt(),
      productUomId: map['product_uom_id']?.toInt(),
      locationIds: List<int>.from(map['location_ids']),
    );
  }

  // String toJson() => json.encode(toMap());

  factory StockLot.fromJson(String source) =>
      StockLot.fromMap(json.decode(source));

  static List<StockLot> fromJsonList(List list) {
    return list.map((item) => StockLot.fromMap(item)).toList();
  }
}
