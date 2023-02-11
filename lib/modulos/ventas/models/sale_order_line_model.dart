import 'dart:convert';

class SaleOrderLine {
  int? id;
  int? productId;
  String? productCode;
  String? name;
  double? productUomQty;
  double? priceUnit;
  double? discount;
  double? montoiva;
  double? priceSubtotal;
  double? priceTotal;
  double? montodiscount;
  int? writeUid;
  String? writeDate;
  String? createDate;
  int? createUid;

  SaleOrderLine({
    this.id,
    this.productId,
    this.productCode,
    this.name,
    this.productUomQty,
    this.priceUnit,
    this.discount,
    this.montoiva,
    this.priceSubtotal,
    this.priceTotal,
    this.montodiscount,
    this.createDate,
    this.createUid,
    this.writeUid,
    this.writeDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'product_code': productCode,
      'name': name,
      'product_uom_qty': productUomQty,
      'price_unit': priceUnit,
      'discount': discount,
      'montoiva': montoiva,
      'price_subtotal': priceSubtotal,
      'price_total': priceTotal,
      'montodiscount': montodiscount,
    };
  }

  factory SaleOrderLine.fromMap(Map<String, dynamic> map) {
    return SaleOrderLine(
      id: map['id']?.toInt(),
      productId: map['product_id']?.toInt(),
      name: map['name'],
      productCode: map['product_code'],
      productUomQty: map['product_uom_qty']?.toDouble(),
      priceUnit: map['price_unit']?.toDouble(),
      discount: map['discount']?.toDouble(),
      montoiva: map['montoiva']?.toDouble(),
      priceSubtotal: map['price_subtotal']?.toDouble(),
      priceTotal: map['price_total']?.toDouble(),
      montodiscount: map['montodiscount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleOrderLine.fromJson(String source) =>
      SaleOrderLine.fromMap(json.decode(source));
}

// class SaleOrderLine {
//   final int? id;
//   final String? product_code;
//   final List<dynamic>? product_id;
//   final String? name;
//   final List<dynamic>? order_id;
//   double? product_uom_qty;
//   double? unit_price;
//   double? product_packaging_qty;
//   List<dynamic>? product_uom;
//   List<dynamic>? product_packaging;
//   final double? price_unit;
//   double? price_packaging;
//   final double? discount;
//   final double? montodiscount;
//   final double? price_subtotal;
//   final double? montoiva;
//   final double? price_total;
//   final double? purchase_price;
//   final double? margin_percent;
//   final List<dynamic>? create_uid;
//   final List<dynamic>? write_uid;
//   final String? create_date;
//   final String? write_date;

//   SaleOrderLine(
//       {this.id,
//       this.product_code,
//       this.product_id,
//       this.name,
//       this.order_id,
//       this.product_uom_qty,
//       this.unit_price,
//       this.product_packaging_qty,
//       this.product_uom,
//       this.product_packaging,
//       this.price_unit,
//       this.price_packaging,
//       this.discount,
//       this.montodiscount,
//       this.price_subtotal,
//       this.montoiva,
//       this.price_total,
//       this.purchase_price,
//       this.margin_percent,
//       this.create_uid,
//       this.write_uid,
//       this.create_date,
//       this.write_date});
//   factory SaleOrderLine.fromJson(Map<String, dynamic> json) =>
//       _$SaleOrderLineFromJson(json);
//   Map<String, dynamic> toJson() => _$SaleOrderLineToJson(this);

//   @override
//   SaleOrderLine fromJson(Map<String, dynamic> json) {
//     return SaleOrderLine.fromJson(json);
//   }

//   @override
//   int? getId() {
//     return this.id;
//   }

//   bool isEqual(SaleOrderLine model) {
//     return this.id == model.id;
//   }

//   @override
//   String getTableName() => "sale.order.line";

//   @override
//   Map<String, dynamic> toJsonWithReduce(
//       bool Function(MapEntry<String, dynamic> p1) validate) {
//     Map<String, dynamic> fields = this.toJson();
//     Map<String, dynamic> tmp = {};
//     final listaMany = [];
//     final listaReadOnly = [];
//     for (final field in fields.entries) {
//       if (validate(field) == false) {
//         continue;
//       }
//       if (listaReadOnly.contains(field.key)) {
//         continue;
//       }
//       if (('${field.value.runtimeType}' == 'List<dynamic>') &&
//           (!listaMany.contains(field.key))) {
//         if (field.value.first == 0) {
//           continue;
//         } else {
//           tmp.putIfAbsent(field.key, () => field.value.first);
//         }
//       }

//       tmp.putIfAbsent(field.key, () => field.value);
//     }
//     return tmp;
//   }

//   @override
//   Map<String, dynamic> toJsonWithoutNullAndId() {
//     return toJsonWithReduce((MapEntry entry) {
//       if (entry.value == null || entry.key == 'id') {
//         return false;
//       }
//       return true;
//     });
//   }

//   @override
//   List<String> getColumns() {
//     List<String> resp = [];
//     final tmp = this.toJson();
//     for (final entry in tmp.keys) {
//       resp.add(entry);
//     }
//     return resp;
//   }
// }

// String revisaVaciosString(value) => value == false ? '' : value;
// double revisaVaciosFloat(value) => value == false ? 0.0 : value;
// int revisaVaciosInt(value) => value == false ? 0 : value;
// List<dynamic> revisamasters(value) => value == false ? [0, ''] : value;
// String crearLinkImagen(value) => value == false ? '' : value;

// SaleOrderLine _$SaleOrderLineFromJson(Map<String, dynamic> json) {
//   final mRecord = SaleOrderLine(
//       id: revisaVaciosInt(json['id']),
//       product_code: revisaVaciosString(json['product_code']),
//       product_id: revisamasters(json['product_id']),
//       name: revisaVaciosString(json['name']),
//       order_id: revisamasters(json['order_id']),
//       price_unit: revisaVaciosFloat(json['price_unit']),
//       discount: revisaVaciosFloat(json['discount']),
//       montodiscount: revisaVaciosFloat(json['montodiscount']),
//       price_subtotal: revisaVaciosFloat(json['price_subtotal']),
//       montoiva: revisaVaciosFloat(json['montoiva']),
//       price_total: revisaVaciosFloat(json['price_total']),
//       purchase_price: revisaVaciosFloat(json['purchase_price']),
//       margin_percent: revisaVaciosFloat(json['margin_percent']),
//       create_uid: revisamasters(json['create_uid']),
//       write_uid: revisamasters(json['write_uid']),
//       create_date: revisaVaciosString(json['create_date']),
//       write_date: revisaVaciosString(json['write_date']));
//   // if (masterController.features.contains('empaques')) {
//   //   mRecord.product_packaging_qty =
//   //       revisaVaciosFloat(json['product_packaging_qty']);
//   //   mRecord.product_packaging = revisamasters(json['product_packaging']);
//   //   mRecord.price_packaging = revisaVaciosFloat(json['price_packaging']);
//   // }
//   // if (masterController.features.contains('precio_unitario')) {
//   //   mRecord.product_uom_qty = revisaVaciosFloat(json['product_uom_qty']);
//   //   mRecord.unit_price = revisaVaciosFloat(json['unit_price']);
//   //   mRecord.product_uom = revisamasters(json['product_uom']);
//   // }
//   return mRecord;
// }

// Map<String, dynamic> _$SaleOrderLineToJson(SaleOrderLine instance) {
//   final mRecord = <String, dynamic>{
//     'id': instance.id,
//     'product_code': instance.product_code,
//     'product_id': instance.product_id,
//     'name': instance.name,
//     'order_id': instance.order_id,
//     'price_unit': instance.price_unit,
//     'discount': instance.discount,
//     'montodiscount': instance.montodiscount,
//     'price_subtotal': instance.price_subtotal,
//     'montoiva': instance.montoiva,
//     'price_total': instance.price_total,
//     'purchase_price': instance.purchase_price,
//     'margin_percent': instance.margin_percent,
//     'create_uid': instance.create_uid,
//     'write_uid': instance.write_uid,
//     'create_date': instance.create_date,
//     'write_date': instance.write_date
//   };
//   // if (masterController.features.contains('empaques')) {
//   //   mRecord['product_packaging_qty'] = instance.product_packaging_qty;
//   //   mRecord['product_packaging'] = instance.product_packaging;
//   //   mRecord['price_packaging'] = instance.price_packaging;
//   // }
//   // if (masterController.features.contains('precio_unitario')) {
//   //   mRecord['product_uom_qty'] = instance.product_uom_qty;
//   //   mRecord['unit_price'] = instance.unit_price;
//   //   mRecord['product_uom'] = instance.product_uom;
//   // }
//   return mRecord;
// }
