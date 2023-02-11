import '../theme/models/used_key_value_db.dart';

class AppDb {
  AppDb._();
  static const UsedKeyValueDb keyValue = UsedKeyValueDb.hive;
  static const String keyValueFilename = 'settings_box_3ep';
}
