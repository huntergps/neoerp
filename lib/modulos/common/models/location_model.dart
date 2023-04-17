import 'dart:convert';

class LocationIdData {
  int? writeUid;
  int? createUid;
  String? writeDate;
  String? usage;
  int? warehouseId;
  int? id;
  String? name;
  int? locationId;
  String? createDate;
  bool? active;

  LocationIdData(
      {this.writeUid,
      this.createUid,
      this.writeDate,
      this.usage,
      this.warehouseId,
      this.id,
      this.name,
      this.locationId,
      this.createDate,
      this.active});

  Map<String, dynamic> toMap() {
    return {
      'writeUid': writeUid,
      'createUid': createUid,
      'writeDate': writeDate,
      'usage': usage,
      'warehouseId': warehouseId,
      'id': id,
      'name': name,
      'locationId': locationId,
      'createDate': createDate,
      'active': active,
    };
  }

  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(LocationIdData model) {
    return id == model.id;
  }

  factory LocationIdData.fromMap(Map<String, dynamic> map) {
    return LocationIdData(
      writeUid: map['writeUid']?.toInt(),
      createUid: map['createUid']?.toInt(),
      writeDate: map['writeDate'],
      usage: map['usage'],
      warehouseId: map['warehouseId']?.toInt(),
      id: map['id']?.toInt(),
      name: map['name'],
      locationId: map['locationId']?.toInt(),
      createDate: map['createDate'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());
  static List<LocationIdData> fromJsonList(List list) {
    return list.map((item) => LocationIdData.fromMap(item)).toList();
  }

  factory LocationIdData.fromJson(String source) =>
      LocationIdData.fromMap(json.decode(source));
}
