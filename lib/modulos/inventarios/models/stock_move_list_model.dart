import 'dart:convert';

import 'package:neo/modulos/widgets/utils.dart';

import '../../common/models/product_model.dart';
import 'stock_move_line_list_model.dart';

class StockMoveList {
  int? id;
  String? createDate;
  int? createUid;
  String? writeDate;
  int? writeUid;
  String? name;
  String? date;
  String? state;

  int? pickingId;
  double? priceUnit;
  List<int>? moveLineIds;
  double? qtyDisponible;
  double? productQty;
  String? productTracking;
  double? productUomQty;
  double? reservedAvailivity;
  double? quantityDone;
  int? productId;
  double? priceSubtotal;
  double? priceSubtotalFinal;

  double? salePriceUnit;
  double? priceUnitFinal;
  String? productCode;
  String? productUomName;
  List<ProductIdData>? productIdData;
  List<StockMoveLineList>? moveLineIdsData;
  int? locationId;
  int? locationDestId;
  int? productUom;
  String? productIdName;

  StockMoveList({
    this.id,
    this.createDate,
    this.createUid,
    this.writeDate,
    this.writeUid,
    this.name,
    this.date,
    this.state,
    this.pickingId,
    this.priceUnit,
    this.priceUnitFinal,
    this.moveLineIds,
    this.productQty,
    this.quantityDone,
    this.reservedAvailivity,
    this.productTracking,
    this.productUomQty,
    this.productId,
    this.qtyDisponible,
    this.priceSubtotal,
    this.priceSubtotalFinal,
    this.salePriceUnit,
    this.productCode,
    this.productUomName,
    this.productIdData,
    this.moveLineIdsData,
    this.locationId,
    this.locationDestId,
    this.productUom,
    this.productIdName,
  });

  bool get precioMal => priceUnitFinal == null || salePriceUnit == null
      ? false
      : (priceUnitFinal! - salePriceUnit!.toDouble()).abs() <
          (salePriceUnit!.toDouble() * 0.02);

  Map<String, dynamic> toMap() {
    return {
      'writeUid': writeUid,
      'pickingId': pickingId,
      'priceUnit': priceUnit,
      'moveLineIds': moveLineIds,
      'createDate': createDate,
      'productQty': productQty,
      'createUid': createUid,
      'writeDate': writeDate,
      'productTracking': productTracking,
      'productUomQty': productUomQty,
      'productId': productId,
      'priceSubtotal': priceSubtotal,
      'priceSubtotalFinal': priceSubtotalFinal,
      'name': name,
      'id': id,
      'state': state,
      'salePriceUnit': salePriceUnit,
      'productCode': productCode,
      'productIdData': productIdData?.map((x) => x.toMap()).toList(),
      'moveLineIdsData': moveLineIdsData?.map((x) => x.toMap()).toList(),
      'location_id': locationId,
    };
  }

  factory StockMoveList.fromMap(Map<String, dynamic> map) {
    return StockMoveList(
      id: revisaVaciosInt(map['id']),
      createDate: map['create_date'],
      createUid: revisaVaciosInt(map['create_uid']),
      writeDate: map['write_date'],
      writeUid: revisaVaciosInt(map['write_uid']),
      name: map['name'],
      state: map['state'],
      pickingId: map['picking_id']?.toInt(),
      priceUnit: revisaVaciosFloat(map['price_unit']),
      priceUnitFinal: revisaVaciosFloat(map['price_unit_final']),
      productQty: revisaVaciosFloat(map['product_qty']),
      productTracking: map['product_tracking'],
      productUomQty: revisaVaciosFloat(map['product_uom_qty']),
      quantityDone: revisaVaciosFloat(map['quantity_done']),
      reservedAvailivity: revisaVaciosFloat(map['reserved_availability']),
      productId: revisaVaciosInt(map['product_id']),
      qtyDisponible: revisaVaciosFloat(map['qty_disponible']),
      locationId: revisaVaciosInt(map['location_id']),
      locationDestId: revisaVaciosInt(map['location_dest_id']),
      productUom: revisaVaciosInt(map['product_uom']),
      priceSubtotal: map['price_subtotal']?.toDouble(),
      priceSubtotalFinal: map['price_subtotal_final']?.toDouble(),
      salePriceUnit: map['sale_price_unit']?.toDouble(),
      productCode: map['product_code'],
      productUomName: map['product_uom_name'],
      moveLineIds: List<int>.from(map['move_line_ids']),
      productIdName: map['product_id_name'],
      productIdData: map['product_id_data'] != null
          ? List<ProductIdData>.from(
              map['product_id_data']?.map((x) => ProductIdData.fromMap(x)))
          : null,
      moveLineIdsData: map['move_line_ids_data'] != null
          ? List<StockMoveLineList>.from(map['move_line_ids_data']
              ?.map((x) => StockMoveLineList.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockMoveList.fromJson(String source) =>
      StockMoveList.fromMap(json.decode(source));

  StockMoveList copyWith({
    int? id,
    String? createDate,
    int? createUid,
    String? writeDate,
    int? writeUid,
    String? name,
    String? date,
    String? state,
    int? pickingId,
    double? priceUnit,
    double? priceUnitFinal,
    List<int>? moveLineIds,
    double? productQty,
    String? productTracking,
    double? productUomQty,
    double? reservedAvailivity,
    double? quantityDone,
    int? productId,
    double? qtyDisponible,
    int? locationId,
    double? priceSubtotal,
    double? priceSubtotalFinal,
    double? salePriceUnit,
    String? productCode,
    String? productUomName,
    List<ProductIdData>? productIdData,
    List<StockMoveLineList>? moveLineIdsData,
    String? productIdName,
  }) {
    return StockMoveList(
      id: id ?? this.id,
      createDate: createDate ?? this.createDate,
      createUid: createUid ?? this.createUid,
      writeDate: writeDate ?? this.writeDate,
      writeUid: writeUid ?? this.writeUid,
      name: name ?? this.name,
      date: date ?? this.date,
      state: state ?? this.state,
      pickingId: pickingId ?? this.pickingId,
      priceUnit: priceUnit ?? this.priceUnit,
      moveLineIds: moveLineIds ?? this.moveLineIds,
      productQty: productQty ?? this.productQty,
      productTracking: productTracking ?? this.productTracking,
      productUomQty: productUomQty ?? this.productUomQty,
      reservedAvailivity: reservedAvailivity ?? this.reservedAvailivity,
      quantityDone: quantityDone ?? this.quantityDone,
      qtyDisponible: qtyDisponible ?? this.qtyDisponible,
      productId: productId ?? this.productId,
      locationId: locationId ?? this.locationId,
      priceSubtotal: priceSubtotal ?? this.priceSubtotal,
      priceSubtotalFinal: priceSubtotalFinal ?? this.priceSubtotalFinal,
      priceUnitFinal: priceUnitFinal ?? this.priceUnitFinal,
      salePriceUnit: salePriceUnit ?? this.salePriceUnit,
      productCode: productCode ?? this.productCode,
      productUomName: productUomName ?? this.productUomName,
      productIdData: productIdData ?? this.productIdData,
      moveLineIdsData: moveLineIdsData ?? this.moveLineIdsData,
      productIdName: productIdName ?? this.productIdName,
    );
  }
}
