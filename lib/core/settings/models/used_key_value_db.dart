
import '../../constants/app_db.dart';
import 'key_value_db.dart';
import 'key_value_db_hive.dart';

/// An enhanced enum used to represent, select and describe the used
/// [KeyValueDb] implementation.
enum UsedKeyValueDb {
  hive(AppDb.keyValueFilename); // Used filename for the Hive storage box.

  final String _filename;
  const UsedKeyValueDb([this._filename = '']);

  KeyValueDb get get {
    return KeyValueDbHive(_filename);
  }

  String get describe => 'Hive';
}
