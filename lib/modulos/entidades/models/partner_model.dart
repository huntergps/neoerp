import 'dart:convert';

import 'package:neo/modulos/widgets/utils.dart';

class PartnerList {
  int? id;
  String? createDate;
  int? createUid;
  String? writeDate;
  int? writeUid;
  String? name;
  String? vat;
  String? email;
  String? phone;
  String? mobile;
  String? street;
  String? city;
  String? website;
  String? tz;
  String? lang;
  bool? active;
  bool? isCompany;
  int? countryId;
  int? lastDayToInvoice;
  bool? noInvoice;
  int? totalCreditAvailibleSales;
  bool? paymentApprovalSale;
  bool? activeLimit;
  int? blockingStage;

  PartnerList({
    this.id,
    this.createDate,
    this.createUid,
    this.writeDate,
    this.writeUid,
    this.name,
    this.vat,
    this.email,
    this.phone,
    this.mobile,
    this.street,
    this.city,
    this.website,
    this.tz,
    this.lang,
    this.active,
    this.isCompany,
    this.countryId,
    this.lastDayToInvoice,
    this.noInvoice,
    this.totalCreditAvailibleSales,
    this.paymentApprovalSale,
    this.activeLimit,
    this.blockingStage,
  });

  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(PartnerList model) {
    return id == model.id;
  }

  @override
  String toString() {
    return name.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'countryId': countryId,
      'city': city,
      'lastDayToInvoice': lastDayToInvoice,
      'createDate': createDate,
      'website': website,
      'tz': tz,
      'createUid': createUid,
      'writeDate': writeDate,
      'phone': phone,
      'street': street,
      'isCompany': isCompany,
      'noInvoice': noInvoice,
      'active': active,
      'totalCreditAvailibleSales': totalCreditAvailibleSales,
      'paymentApprovalSale': paymentApprovalSale,
      'lang': lang,
      'activeLimit': activeLimit,
      'name': name,
      'email': email,
      'blockingStage': blockingStage,
      'id': id,
      'mobile': mobile,
      'vat': vat,
    };
  }

  factory PartnerList.fromMap(Map<String, dynamic> map) {
    return PartnerList(
      id: revisaVaciosInt(map['id']),
      createDate: map['create_date'],
      createUid: revisaVaciosInt(map['create_uid']),
      writeDate: map['write_date'],
      writeUid: revisaVaciosInt(map['write_uid']),
      name: map['name'],
      city: map['city'],
      lastDayToInvoice: map['last_day_to_invoice']?.toInt(),
      website: revisaVaciosString(map['website']),
      tz: map['tz'],
      phone: revisaVaciosString(map['phone']),
      street: revisaVaciosString(map['street']),
      isCompany: map['is_company'],
      noInvoice: map['no_invoice'],
      active: map['active'],
      totalCreditAvailibleSales: map['total_credit_availible_sales']?.toInt(),
      paymentApprovalSale: map['payment_approval_sale'],
      lang: map['lang'],
      activeLimit: map['active_limit'],
      email: revisaVaciosString(map['email']),
      blockingStage: map['blocking_stage']?.toInt(),
      mobile: revisaVaciosString(map['mobile']),
      vat: revisaVaciosString(map['vat']),
    );
  }

  static List<PartnerList> fromJsonList(List list) {
    return list.map((item) => PartnerList.fromMap(item)).toList();
  }

  String toJson() => json.encode(toMap());

  factory PartnerList.fromJson(String source) =>
      PartnerList.fromMap(json.decode(source));
}
