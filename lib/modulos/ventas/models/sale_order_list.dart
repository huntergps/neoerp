import 'package:neo/modulos/widgets/utils.dart';

class SaleOrderList {
  int? id;
  String? name;
  String? invoiceDate;
  String? dateOrder;
  String? validityDate;
  String? state;
  String? invoiceStatus;
  String? origin;
  String? clienteRuc;
  String? clienteName;
  double? totalSri;
  String? paymentTermName;
  String? userName;
  int? createUid;
  String? createDate;
  int? writeUid;
  String? writeDate;
  String? estadoDespachos;

  SaleOrderList({
    this.id,
    this.name,
    this.invoiceDate,
    this.dateOrder,
    this.validityDate,
    this.state,
    this.invoiceStatus,
    this.origin,
    this.clienteRuc,
    this.clienteName,
    this.totalSri,
    this.paymentTermName,
    this.userName,
    this.createUid,
    this.createDate,
    this.writeDate,
    this.writeUid,
    this.estadoDespachos,
  });

  SaleOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    invoiceDate = json['invoice_date'];
    dateOrder = json['date_order'];
    validityDate = json['validity_date'];
    state = json['state'];
    invoiceStatus = json['invoice_status'];
    origin = json['origin'];
    clienteRuc = json['cliente_ruc'];
    clienteName = json['cliente_name'];
    totalSri = revisaVaciosFloat(json['total_sri']);
    paymentTermName = json['payment_term_name'];
    userName = json['user_name'];
    createUid = revisaVaciosInt(json['create_uid']);
    createDate = json['create_date'];
    writeDate = json['write_date'];
    writeUid = revisaVaciosInt(json['write_uid']);
    estadoDespachos = revisaVaciosString(json['estado_despachos']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_date'] = invoiceDate;
    data['date_order'] = dateOrder;
    data['validity_date'] = validityDate;
    data['state'] = state;
    data['name'] = name;
    data['invoice_status'] = invoiceStatus;
    data['create_uid'] = createUid;
    data['id'] = id;
    data['create_date'] = createDate;
    data['write_date'] = writeDate;
    data['origin'] = origin;
    data['write_uid'] = writeUid;
    data['cliente_name'] = clienteName;
    data['cliente_ruc'] = clienteRuc;
    data['total_sri'] = totalSri;

    return data;
  }
}
