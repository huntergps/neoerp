class SessionValues {
  int? statusCode;
  String? error;
  String? time;
  String? now;
  String? token;
  String? release;
  String? expire;
  String? uid;
  String? username;
  String? name;
  String? empresa;
  String? tz;
  String? lang;
  String? email;
  int? autorizacionFacturasId;
  int? autorizacionNotasCreditoId;
  String? cajas;

  SessionValues(
      {this.statusCode,
      this.error,
      this.time,
      this.now,
      this.token,
      this.release,
      this.expire,
      this.uid,
      this.username,
      this.name,
      this.empresa,
      this.tz,
      this.lang,
      this.email,
      this.autorizacionFacturasId,
      this.autorizacionNotasCreditoId,
      this.cajas});

  SessionValues.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    time = json['time'];
    now = json['now'];
    token = json['token'];
    release = json['release'];
    expire = json['expire'];
    uid = json['uid'];
    username = json['username'];
    name = json['name'];
    empresa = json['empresa'];
    tz = json['tz'];
    lang = json['lang'];
    email = json['email'];
    autorizacionFacturasId = json['autorizacion_facturas_id'];
    autorizacionNotasCreditoId = json['autorizacion_notas_credito_id'];
    cajas = json['cajas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['error'] = error;

    data['time'] = time;
    data['now'] = now;
    data['token'] = token;
    data['release'] = release;
    data['expire'] = expire;
    data['uid'] = uid;
    data['username'] = username;
    data['name'] = name;
    data['empresa'] = empresa;
    data['tz'] = tz;
    data['lang'] = lang;
    data['email'] = email;
    data['autorizacion_facturas_id'] = autorizacionFacturasId;
    data['autorizacion_notas_credito_id'] = autorizacionNotasCreditoId;
    data['cajas'] = cajas;
    return data;
  }
}
