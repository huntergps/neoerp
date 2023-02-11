import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/models/settings_entry.dart';

const bool _debug = !kReleaseMode && true;

class Session {
  Session._();

  static const String _serverPassword = '';

  static void reset(WidgetRef ref) {
    if (_debug) debugPrint('Session: reset all DB values');
    ref.read(serverPasswordProvider.notifier).reset();
  }

  static void init(Ref ref) {
    if (_debug) debugPrint('Session: init DB values');
    ref.read(serverPasswordProvider.notifier).init();
  }

  static const String _keyServerPassword = 'serverPassword ';
  static final NotifierProvider<SettingsEntry<String>, String>
      serverPasswordProvider = NotifierProvider<SettingsEntry<String>, String>(
    () {
      return SettingsEntry<String>(
        defaultValue: _serverPassword,
        key: _keyServerPassword,
      );
    },
    name: '${_keyServerPassword}Provider',
  );
}
