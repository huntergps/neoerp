import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/settings/controllers/settings.dart';

final dioHttpProvider = Provider<Dio>((ref) => Dio(
      BaseOptions(
        baseUrl: ref.watch(Settings.serverUrlProvider),
        headers: {
          "Content-Type": "aapplication/text",
          "Access-Token": ref.watch(Settings.sessionIdProvider)
        },
      ),
    ));

final dioErrorMsnProvider = StateProvider<String>(
  (ref) => '',
);

final dioLoadingProvider = StateProvider<bool>(
  (ref) => false,
);
