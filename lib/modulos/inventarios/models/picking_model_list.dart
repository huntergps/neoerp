import 'dart:convert';

import '../../widgets/utils.dart';

class PickingOrderList {
  int? id;
  String? createDate;
  int? createUid;
  String? writeDate;
  int? writeUid;
  String? name;
  String? state;
  String? origin;
  String? scheduledDate;
  String? clienteRuc;
  String? clienteName;
  String? locationName;
  String? locationDestName;
  String? pickingTypeName;
  String? userName;
  String? priority;

  PickingOrderList({
    this.id,
    this.createDate,
    this.createUid,
    this.writeDate,
    this.writeUid,
    this.name,
    this.state,
    this.origin,
    this.scheduledDate,
    this.clienteRuc,
    this.clienteName,
    this.locationName,
    this.locationDestName,
    this.pickingTypeName,
    this.userName,
    this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'write_date': writeDate,
      'id': id,
      'state': state,
      'create_date': createDate,
      'create_uid': createUid,
      'origin': origin,
      'scheduled_date': scheduledDate,
      'name': name,
      'write_uid': writeUid,
      'cliente_ruc': clienteRuc,
      'cliente_name': clienteName,
    };
  }

  factory PickingOrderList.fromJson(Map<String, dynamic> map) {
    return PickingOrderList(
      id: revisaVaciosInt(map['id']),
      createDate: map['create_date'],
      createUid: revisaVaciosInt(map['create_uid']),
      writeDate: map['write_date'],
      writeUid: revisaVaciosInt(map['write_uid']),
      name: map['name'],
      state: map['state'],
      origin: map['origin'],
      scheduledDate: map['scheduled_date'],
      clienteRuc: revisaVaciosString(map['cliente_ruc']),
      clienteName: revisaVaciosString(map['cliente_name']),
      locationName: revisaVaciosString(map['location_name']),
      locationDestName: revisaVaciosString(map['location_dest_name']),
      pickingTypeName: revisaVaciosString(map['picking_type_name']),
      userName: map['user_name_login'],
      priority: map['priority'],
    );
  }

  String toJson() => json.encode(toMap());
}
