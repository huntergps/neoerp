import 'dart:convert';

class UserList {
  String? email;
  int? writeUid;
  String? tz;
  int? createUid;
  String? writeDate;
  String? lang;
  int? partnerId;
  bool? autorizacionFacturasId;
  bool? autorizacionGuiasRemisionId;
  int? id;
  String? password;
  bool? autorizacionNotasCreditoId;
  String? name;
  bool? active;
  String? createDate;
  String? login;

  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(UserList model) {
    return id == model.id;
  }

  @override
  String toString() {
    return name.toString();
  }

  UserList(
      {this.email,
      this.writeUid,
      this.tz,
      this.createUid,
      this.writeDate,
      this.lang,
      this.partnerId,
      this.autorizacionFacturasId,
      this.autorizacionGuiasRemisionId,
      this.id,
      this.password,
      this.autorizacionNotasCreditoId,
      this.name,
      this.active,
      this.createDate,
      this.login});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'writeUid': writeUid,
      'tz': tz,
      'createUid': createUid,
      'writeDate': writeDate,
      'lang': lang,
      'partnerId': partnerId,
      'autorizacionFacturasId': autorizacionFacturasId,
      'autorizacionGuiasRemisionId': autorizacionGuiasRemisionId,
      'id': id,
      'password': password,
      'autorizacionNotasCreditoId': autorizacionNotasCreditoId,
      'name': name,
      'active': active,
      'createDate': createDate,
      'login': login,
    };
  }

  factory UserList.fromMap(Map<String, dynamic> map) {
    return UserList(
      email: map['email'],
      writeUid: map['writeUid']?.toInt(),
      tz: map['tz'],
      createUid: map['createUid']?.toInt(),
      writeDate: map['writeDate'],
      lang: map['lang'],
      partnerId: map['partnerId']?.toInt(),
      autorizacionFacturasId: map['autorizacionFacturasId'],
      autorizacionGuiasRemisionId: map['autorizacionGuiasRemisionId'],
      id: map['id']?.toInt(),
      password: map['password'],
      autorizacionNotasCreditoId: map['autorizacionNotasCreditoId'],
      name: map['name'],
      active: map['active'],
      createDate: map['createDate'],
      login: map['login'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserList.fromJson(String source) =>
      UserList.fromMap(json.decode(source));

  static List<UserList> fromJsonList(List list) {
    return list.map((item) => UserList.fromMap(item)).toList();
  }
}
