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
