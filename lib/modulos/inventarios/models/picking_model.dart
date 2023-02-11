import 'dart:convert';

import '../../common/models/location_model.dart';
import '../../common/models/user_model.dart';
import '../../entidades/models/partner_model.dart';
import '../../widgets/utils.dart';
import 'stock_move_list_model.dart';

class PickingOrder {
  int? id;
  String? createDate;
  int? createUid;
  String? writeDate;
  int? writeUid;
  String? name;
  String? date;
  String? state;
  String? priority;
  String? dateDone;
  String? nroGuia;
  String? estadoFactura;
  int? companyId;
  int? partnerId;
  int? partnerVentaId;
  int? userId;
  int? pickingTypeId;
  int? locationDestId;
  int? backorderId;
  int? locationId;
  int? saleId;
  String? moveType;
  String? origin;
  String? scheduledDate;
  String? clienteRuc;
  String? clienteName;
  String? clienteVentaRuc;
  String? clienteVentaName;
  String? locationName;
  String? locationDestName;
  String? pickingTypeName;
  String? userName;
  String? note;
  String? stateType;
  List<int>? moveLines;
  List<PartnerList>? partnerIdData;
  List<PartnerList>? partnerVentaIdData;
  List<UserList>? userIdData;
  List<LocationIdData>? locationIdData;
  List<LocationIdData>? locationDestIdData;
  List<StockMoveList>? moveLinesData;

  PickingOrder({
    this.id,
    this.createDate,
    this.createUid,
    this.writeDate,
    this.writeUid,
    this.name,
    this.date,
    this.state,
    this.priority,
    this.dateDone,
    this.nroGuia,
    this.estadoFactura,
    this.companyId,
    this.partnerId,
    this.partnerVentaId,
    this.userId,
    this.pickingTypeId,
    this.locationDestId,
    this.backorderId,
    this.locationId,
    this.saleId,
    this.moveType,
    this.origin,
    this.scheduledDate,
    this.clienteRuc,
    this.clienteName,
    this.clienteVentaRuc,
    this.clienteVentaName,
    this.locationName,
    this.locationDestName,
    this.pickingTypeName,
    this.userName,
    this.note,
    this.stateType,
    this.moveLines,
    this.partnerIdData,
    this.partnerVentaIdData,
    this.userIdData,
    this.locationIdData,
    this.locationDestIdData,
    this.moveLinesData,
  });

  Map<String, dynamic> toMap() {
    return {
      'writeUid': writeUid,
      'scheduledDate': scheduledDate,
      'moveLines': moveLines,
      'pickingTypeId': pickingTypeId,
      'partnerVentaId': partnerVentaId,
      'createDate': createDate,
      'note': note,
      'createUid': createUid,
      'writeDate': writeDate,
      'dateDone': dateDone,
      'nroGuia': nroGuia,
      'userId': userId,
      'estadoFactura': estadoFactura,
      'partnerId': partnerId,
      'saleId': saleId,
      'locationDestId': locationDestId,
      'name': name,
      'date': date,
      'companyId': companyId,
      'backorderId': backorderId,
      'id': id,
      'state': state,
      'origin': origin,
      'locationId': locationId,
      'moveType': moveType,
      'partnerVentaIdData': partnerVentaIdData?.map((x) => x.toMap()).toList(),
      'user_id_data': userIdData?.map((x) => x.toMap()).toList(),
      'locationIdData': locationIdData?.map((x) => x.toMap()).toList(),
      'locationDestIdData': locationDestIdData?.map((x) => x.toMap()).toList(),
      'moveLinesData': moveLinesData?.map((x) => x.toMap()).toList(),
    };
  }

  factory PickingOrder.fromMap(Map<String, dynamic> map) {
    return PickingOrder(
      id: revisaVaciosInt(map['id']),
      createDate: map['create_date'],
      createUid: revisaVaciosInt(map['create_uid']),
      writeDate: map['write_date'],
      writeUid: revisaVaciosInt(map['write_uid']),
      name: map['name'],
      date: map['date'],
      state: map['state'],
      priority: map['priority'],
      dateDone: map['date_done'],
      nroGuia: map['nro_guia'],
      estadoFactura: map['estado_factura'],
      // companyId: revisaVaciosInt(map['company_id']),
      partnerId: revisaVaciosInt(map['partner_id']),
      partnerVentaId: revisaVaciosInt(map['partner_venta_id']),
      userId: revisaVaciosInt(map['user_id']),
      pickingTypeId: revisaVaciosInt(map['picking_type_id']),
      locationDestId: revisaVaciosInt(map['location_dest_id']),
      locationId: map['location_id']?.toInt(),
      backorderId: revisaVaciosInt(map['backorder_id']),
      saleId: revisaVaciosInt(map['sale_id']),
      moveType: map['move_type'],
      origin: map['origin'],
      scheduledDate: map['scheduled_date'],
      clienteRuc: revisaVaciosString(map['cliente_ruc']),
      clienteName: revisaVaciosString(map['cliente_name']),
      clienteVentaRuc: revisaVaciosString(map['cliente_venta_ruc']),
      clienteVentaName: revisaVaciosString(map['cliente_venta_name']),
      locationName: revisaVaciosString(map['location_name']),
      locationDestName: revisaVaciosString(map['location_dest_name']),
      pickingTypeName: revisaVaciosString(map['picking_type_name']),
      userName: map['user_name'],
      note: map['note'],
      stateType: revisaVaciosString(map['state_type']),
      moveLines: List<int>.from(map['move_lines']),
      partnerIdData: map['partner_id_data'] != null
          ? List<PartnerList>.from(
              map['partner_id_data']?.map((x) => PartnerList.fromMap(x)))
          : null,
      partnerVentaIdData: map['partner_venta_id_data'] != null
          ? List<PartnerList>.from(
              map['partner_venta_id_data']?.map((x) => PartnerList.fromMap(x)))
          : null,
      userIdData: map['user_id_data'] != null
          ? List<UserList>.from(
              map['user_id_data']?.map((x) => UserList.fromMap(x)))
          : null,
      locationIdData: map['location_id_data'] != null
          ? List<LocationIdData>.from(
              map['location_id_data']?.map((x) => LocationIdData.fromMap(x)))
          : null,
      locationDestIdData: map['location_dest_id_data'] != null
          ? List<LocationIdData>.from(map['location_dest_id_data']
              ?.map((x) => LocationIdData.fromMap(x)))
          : null,
      moveLinesData: map['move_lines_data'] != null
          ? List<StockMoveList>.from(
              map['move_lines_data']?.map((x) => StockMoveList.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickingOrder.fromJson(String source) =>
      PickingOrder.fromMap(json.decode(source));

  PickingOrder copyWith({
    int? id,
    String? createDate,
    int? createUid,
    String? writeDate,
    int? writeUid,
    String? name,
    String? date,
    String? state,
    String? priority,
    String? dateDone,
    String? nroGuia,
    String? estadoFactura,
    int? companyId,
    int? partnerId,
    int? partnerVentaId,
    int? userId,
    int? pickingTypeId,
    int? locationDestId,
    int? backorderId,
    int? locationId,
    int? saleId,
    String? moveType,
    String? origin,
    String? scheduledDate,
    String? clienteRuc,
    String? clienteName,
    String? clienteVentaRuc,
    String? clienteVentaName,
    String? locationName,
    String? locationDestName,
    String? pickingTypeName,
    String? userName,
    String? note,
    String? stateType,
    List<int>? moveLines,
    List<PartnerList>? partnerIdData,
    List<PartnerList>? partnerVentaIdData,
    List<UserList>? userIdData,
    List<LocationIdData>? locationIdData,
    List<LocationIdData>? locationDestIdData,
    List<StockMoveList>? moveLinesData,
  }) {
    return PickingOrder(
      id: id ?? this.id,
      createDate: createDate ?? this.createDate,
      createUid: createUid ?? this.createUid,
      writeDate: writeDate ?? this.writeDate,
      writeUid: writeUid ?? this.writeUid,
      name: name ?? this.name,
      date: date ?? this.date,
      state: state ?? this.state,
      priority: priority ?? this.priority,
      dateDone: dateDone ?? this.dateDone,
      nroGuia: nroGuia ?? this.nroGuia,
      estadoFactura: estadoFactura ?? this.estadoFactura,
      companyId: companyId ?? this.companyId,
      partnerId: partnerId ?? this.partnerId,
      partnerVentaId: partnerVentaId ?? this.partnerVentaId,
      userId: userId ?? this.userId,
      pickingTypeId: pickingTypeId ?? this.pickingTypeId,
      locationDestId: locationDestId ?? this.locationDestId,
      backorderId: backorderId ?? this.backorderId,
      locationId: locationId ?? this.locationId,
      saleId: saleId ?? this.saleId,
      moveType: moveType ?? this.moveType,
      origin: origin ?? this.origin,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      clienteRuc: clienteRuc ?? this.clienteRuc,
      clienteName: clienteName ?? this.clienteName,
      clienteVentaRuc: clienteVentaRuc ?? this.clienteVentaRuc,
      clienteVentaName: clienteVentaName ?? this.clienteVentaName,
      locationName: locationName ?? this.locationName,
      locationDestName: locationDestName ?? this.locationDestName,
      pickingTypeName: pickingTypeName ?? this.pickingTypeName,
      userName: userName ?? this.userName,
      note: note ?? this.note,
      stateType: stateType ?? this.stateType,
      moveLines: moveLines ?? this.moveLines,
      partnerIdData: partnerIdData ?? this.partnerIdData,
      partnerVentaIdData: partnerVentaIdData ?? this.partnerVentaIdData,
      userIdData: userIdData ?? this.userIdData,
      locationIdData: locationIdData ?? this.locationIdData,
      locationDestIdData: locationDestIdData ?? this.locationDestIdData,
      moveLinesData: moveLinesData ?? this.moveLinesData,
    );
  }
}
