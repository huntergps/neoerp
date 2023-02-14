import 'dart:convert';

import 'package:neo/modulos/widgets/utils.dart';

class StockMoveLineList {
  int? id;
  String? createDate;
  int? createUid;
  String? writeDate;
  int? writeUid;
  String? state;

  int? productUomId;
  bool? packageId;
  int? lotId;
  int? productId;
  double? productQty;

  double? productUomQty;
  double? qtyDone;
  int? moveId;
  int? pickingId;
  String? lotName;
  String? lotIdName;
  String? productTracking;
  int? locationId;
  int? locationDestId;

  StockMoveLineList({
    this.productUomQty,
    this.productUomId,
    this.packageId,
    this.lotId,
    this.id,
    this.createUid,
    this.writeDate,
    this.productId,
    this.qtyDone,
    this.productQty,
    this.writeUid,
    this.moveId,
    this.createDate,
    this.pickingId,
    this.lotName,
    this.lotIdName,
    this.productTracking,
    this.locationId,
    this.locationDestId,
    this.state,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createDate': createDate,
      'createUid': createUid,
      'writeDate': writeDate,
      'writeUid': writeUid,
      'productUomQty': productUomQty,
      'productUomId': productUomId,
      'packageId': packageId,
      'lotId': lotId,
      'productId': productId,
      'qtyDone': qtyDone,
      'productQty': productQty,
      'moveId': moveId,
      'pickingId': pickingId,
      'loteName': lotName,
      'lot_id_name': lotIdName,
      'product_tracking': productTracking,
    };
  }

  factory StockMoveLineList.fromMap(Map<String, dynamic> map) {
    return StockMoveLineList(
      id: revisaVaciosInt(map['id']),
      createDate: map['create_date'],
      createUid: revisaVaciosInt(map['create_uid']),
      writeDate: map['write_date'],
      writeUid: revisaVaciosInt(map['write_uid']),
      productUomQty: revisaVaciosFloat(map['product_uom_qty']),
      productUomId: map['product_uom_id']?.toInt(),
      packageId: map['package_id'],
      lotId: revisaVaciosInt(map['lot_id']),
      productId: revisaVaciosInt(map['product_id']),
      qtyDone: revisaVaciosFloat(map['qty_done']),
      productQty: revisaVaciosFloat(map['product_qty']),
      moveId: map['move_id']?.toInt(),
      pickingId: map['picking_id']?.toInt(),
      lotName: revisaVaciosString(map['lot_name']),
      lotIdName: revisaVaciosString(map['lot_id_name']),
      productTracking: revisaVaciosString(map['product_tracking']),
      locationId: revisaVaciosInt(map['location_id']),
      locationDestId: revisaVaciosInt(map['location_dest_id']),
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockMoveLineList.fromJson(String source) =>
      StockMoveLineList.fromMap(json.decode(source));

  StockMoveLineList copyWith({
    int? id,
    String? createDate,
    int? createUid,
    String? writeDate,
    int? writeUid,
    int? productUomId,
    bool? packageId,
    int? lotId,
    int? productId,
    double? productQty,
    double? productUomQty,
    double? qtyDone,
    int? moveId,
    int? pickingId,
    String? lotName,
    String? lotIdName,
    String? productTracking,
    int? locationId,
    int? locationDestId,
    String? state,
  }) {
    return StockMoveLineList(
      id: id ?? this.id,
      createDate: createDate ?? this.createDate,
      createUid: createUid ?? this.createUid,
      writeDate: writeDate ?? this.writeDate,
      writeUid: writeUid ?? this.writeUid,
      productUomId: productUomId ?? this.productUomId,
      packageId: packageId ?? this.packageId,
      lotId: lotId ?? this.lotId,
      productId: productId ?? this.productId,
      productQty: productQty ?? this.productQty,
      productUomQty: productUomQty ?? this.productUomQty,
      qtyDone: qtyDone ?? this.qtyDone,
      moveId: moveId ?? this.moveId,
      pickingId: pickingId ?? this.pickingId,
      lotName: lotName ?? this.lotName,
      lotIdName: lotIdName ?? this.lotIdName,
      productTracking: productTracking ?? this.productTracking,
      locationId: locationId ?? this.locationId,
      locationDestId: locationDestId ?? this.locationDestId,
      state: state ?? this.state,
    );
  }
}
