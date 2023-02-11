import 'dart:convert';

import 'package:neo/modulos/inventarios/models/picking_model_list.dart';

import '../../widgets/utils.dart';
import '../../entidades/models/partner_model.dart';
import 'sale_order_line_model.dart';

class SaleOrder {
  int? id;
  String? name;
  String? createDate;
  int? createUid;
  String? writeDate;
  int? writeUid;
  int? partnerId;
  String? origin;
  String? accessToken;
  String? reference;
  String? state;
  String? dateOrder;
  String? validityDate;
  String? invoiceDate;
  String? invoiceStatus;
  String? note;
  String? paymentTermName;
  String? acuerdoName;
  String? shareLinkSo;
  String? userNameLogin;
  double? costTotal;
  double? amountDiscount;
  double? basenograiva;
  double? baseimpgrav;
  double? baseimpexe;
  double? baseimponible;
  double? subtotalSri;
  double? montoiva;
  double? montoice;
  double? totalSri;
  double? margin;
  double? marginPercentGeneral;
  List<int>? orderLine;
  List<int>? pickingIds;
  List<PickingOrderList>? pickingIdsData;
  List<PartnerList>? partnerIdData;
  List<SaleOrderLine>? orderLineData;

  SaleOrder(
      {this.id,
      this.name,
      this.createDate,
      this.createUid,
      this.writeDate,
      this.writeUid,
      this.partnerId,
      this.origin,
      this.accessToken,
      this.reference,
      this.state,
      this.dateOrder,
      this.validityDate,
      this.invoiceDate,
      this.invoiceStatus,
      this.note,
      this.paymentTermName,
      this.acuerdoName,
      this.shareLinkSo,
      this.userNameLogin,
      this.costTotal,
      this.amountDiscount,
      this.basenograiva,
      this.baseimpgrav,
      this.baseimpexe,
      this.baseimponible,
      this.subtotalSri,
      this.montoiva,
      this.montoice,
      this.totalSri,
      this.margin,
      this.marginPercentGeneral,
      this.orderLine,
      this.pickingIds,
      this.partnerIdData,
      this.orderLineData,
      this.pickingIdsData});

  Map<String, dynamic> toMap() {
    return {
      'invoiceDate': invoiceDate,
      'invoiceStatus': invoiceStatus,
      'writeUid': writeUid,
      'createDate': createDate,
      'validityDate': validityDate,
      'createUid': createUid,
      'writeDate': writeDate,
      'accessToken': accessToken,
      'name': name,
      'dateOrder': dateOrder,
      'order_line': orderLine,
      'picking_ids': pickingIds,
      'id': id,
      'state': state,
      'origin': origin,
      'reference': reference,
      'partnerIdData': partnerIdData?.map((x) => x.toMap()).toList(),
      'order_line_data': orderLineData?.map((x) => x.toMap()).toList(),
      'margin': margin,
      'margin_percent_general': marginPercentGeneral,
      'cost_total': costTotal,
      'baseimpgrav': baseimpgrav,
      'baseimponible': baseimponible,
      'subtotal_sri': subtotalSri,
      'amount_discount': amountDiscount,
      'monto_iva': montoiva,
      'total_sri': totalSri,
      'share_link_so': shareLinkSo,
    };
  }

  factory SaleOrder.fromMap(Map<String, dynamic> map) {
    // print(map['order_line_data']);
    // print("**************************************");
    return SaleOrder(
      id: map['id']?.toInt(),
      name: map['name'],
      createUid: map['create_uid'],
      createDate: map['create_date'],
      writeDate: map['write_date'],
      writeUid: map['write_uid'],
      partnerId: map['partner_id'],
      userNameLogin: map['user_name_login'],
      origin: map['origin'],
      accessToken: map['access_token'],
      reference: map['reference'],
      state: map['state'],
      dateOrder: map['date_order'],
      validityDate: map['validity_date'],
      invoiceDate: map['invoice_date'],
      invoiceStatus: map['invoice_status'],
      note: map['note'],
      paymentTermName: map['payment_term_name'],
      acuerdoName: map['acuerdo_name'],
      shareLinkSo: map['share_link_so'],
      amountDiscount: map['amount_discount']?.toDouble(),
      marginPercentGeneral: map['margin_percent_general']?.toDouble(),
      costTotal: map['cost_total']?.toDouble(),
      margin: map['margin']?.toDouble(),
      basenograiva: map['basenograiva']?.toDouble(),
      baseimponible: map['baseimponible']?.toDouble(),
      baseimpgrav: map['baseimpgrav']?.toDouble(),
      baseimpexe: map['baseimpexe']?.toDouble(),
      montoiva: map['montoiva']?.toDouble(),
      montoice: map['montoice']?.toDouble(),
      subtotalSri: map['subtotal_sri']?.toDouble(),
      totalSri: revisaVaciosFloat(map['total_sri']),
      orderLine: List<int>.from(map['order_line']),
      pickingIds: List<int>.from(map['picking_ids']),
      pickingIdsData: map['picking_ids_data'] != null
          ? List<PickingOrderList>.from(
              map['picking_ids_data']?.map((x) => PickingOrderList.fromJson(x)))
          : null,
      partnerIdData: map['partner_id_data'] != null
          ? List<PartnerList>.from(
              map['partner_id_data']?.map((x) => PartnerList.fromMap(x)))
          : null,
      orderLineData: map['order_line_data'] != null
          ? List<SaleOrderLine>.from(
              map['order_line_data']?.map((x) => SaleOrderLine.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleOrder.fromJson(String source) =>
      SaleOrder.fromMap(json.decode(source));
}
