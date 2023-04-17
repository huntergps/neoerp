import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/settings/controllers/settings.dart';
import 'models/session_model.dart';

final dioLoginProvider = Provider<Dio>((ref) => Dio(
      BaseOptions(
        baseUrl: ref.watch(Settings.serverUrlProvider),
        headers: {"Content-Type": "aapplication/text"},
      ),
    ));

final sessionProvider = StateProvider<SessionValues>(
  (_) => SessionValues(),
);

final loginErrorMsnProvider = StateProvider<String>(
  (ref) => '',
);

final loginLoadingProvider = StateProvider<bool>(
  (ref) => false,
);

final displayModeProvider = StateProvider<PaneDisplayMode>(
  (ref) => PaneDisplayMode.minimal,
);
