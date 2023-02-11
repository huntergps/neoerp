import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/used_key_value_db_provider.dart';
import 'key_value_db.dart';

const bool _debug = !kReleaseMode && true;

final StateProvider<KeyValueDb> keyValueDbProvider =
    StateProvider<KeyValueDb>((StateProviderRef<KeyValueDb> ref) {
  ref.onDispose(() {
    if (_debug) debugPrint('keyValueDbProvider: onDispose called');
  });
  return ref.watch(usedKeyValueDbProvider).get;
}, name: 'keyValueDbProvider');
