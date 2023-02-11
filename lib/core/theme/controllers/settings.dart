import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:system_theme/system_theme.dart';

import '../models/settings_entry.dart';

const bool _debug = !kReleaseMode && true;

class Settings {
  Settings._();

  static const String _sessionId = '';
  static const String _serverUrl = '';
  static const String _serverDB = '';
  static const String _serverUser = '';
  static const String _serverPassword = '';

  static const ThemeMode _themeMode = ThemeMode.system;
  static final AccentColor _accentColor = Colors.orange; //systemAccentColor();
  static const PaneDisplayMode _displayMode = PaneDisplayMode.minimal;

  static void reset(WidgetRef ref) {
    if (_debug) debugPrint('Settings: reset all DB values');
    ref.read(themeModeProvider.notifier).reset();
    ref.read(sessionIdProvider.notifier).reset();
    ref.read(serverUserProvider.notifier).reset();
    ref.read(serverPasswordProvider.notifier).reset();
  }

  static void init(Ref ref) {
    if (_debug) debugPrint('Settings: init DB values');
    ref.read(themeModeProvider.notifier).init();
    ref.read(sessionIdProvider.notifier).init();
    ref.read(serverUserProvider.notifier).init();
    ref.read(serverPasswordProvider.notifier).init();
  }

  static const String _keySessionId = 'sessionId ';
  static final NotifierProvider<SettingsEntry<String>, String>
      sessionIdProvider = NotifierProvider<SettingsEntry<String>, String>(
    () {
      return SettingsEntry<String>(
        defaultValue: _sessionId,
        key: _keySessionId,
      );
    },
    name: '${_keySessionId}Provider',
  );

  static const String _keyServerUrl = 'serverUrl';
  static final NotifierProvider<SettingsEntry<String>, String>
      serverUrlProvider = NotifierProvider<SettingsEntry<String>, String>(
    () {
      return SettingsEntry<String>(
        defaultValue: _serverUrl,
        key: _keyServerUrl,
      );
    },
    name: '${_keyServerUrl}Provider',
  );

  static const String _keyServerDB = 'serverDB';
  static final NotifierProvider<SettingsEntry<String>, String>
      serverDBProvider = NotifierProvider<SettingsEntry<String>, String>(
    () {
      return SettingsEntry<String>(
        defaultValue: _serverDB,
        key: _keyServerDB,
      );
    },
    name: '${_keyServerDB}Provider',
  );

  static const String _keyServerUser = 'serverUser ';
  static final NotifierProvider<SettingsEntry<String>, String>
      serverUserProvider = NotifierProvider<SettingsEntry<String>, String>(
    () {
      return SettingsEntry<String>(
        defaultValue: _serverUser,
        key: _keyServerUser,
      );
    },
    name: '${_keyServerUser}Provider',
  );

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

  static const String _keyThemeMode = 'themeMode';
  static final NotifierProvider<SettingsEntry<ThemeMode>, ThemeMode>
      themeModeProvider = NotifierProvider<SettingsEntry<ThemeMode>, ThemeMode>(
    () {
      return SettingsEntry<ThemeMode>(
        defaultValue: _themeMode,
        key: _keyThemeMode,
      );
    },
    name: '${_keyThemeMode}Provider',
  );

  static const String _keyAccentColor = 'accentColor';
  static final NotifierProvider<SettingsEntry<AccentColor>, AccentColor>
      accentColorProvider =
      NotifierProvider<SettingsEntry<AccentColor>, AccentColor>(
    () {
      return SettingsEntry<AccentColor>(
        defaultValue: _accentColor,
        key: _keyAccentColor,
      );
    },
    name: '${_keyAccentColor}Provider',
  );

  static const String _keyPaneDisplayMode = 'displayMode';
  static final NotifierProvider<SettingsEntry<PaneDisplayMode>, PaneDisplayMode>
      displayModeProvider =
      NotifierProvider<SettingsEntry<PaneDisplayMode>, PaneDisplayMode>(
    () {
      return SettingsEntry<PaneDisplayMode>(
        defaultValue: _displayMode,
        key: _keyPaneDisplayMode,
      );
    },
    name: '${_keyPaneDisplayMode}Provider',
  );
}

AccentColor systemAccentColor() {
  if ((defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.android) &&
      !kIsWeb) {
    return AccentColor.swatch({
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
