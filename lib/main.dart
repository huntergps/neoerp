import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/core/theme/models/key_value_db_listener.dart';
import 'package:neo/core/theme/models/key_value_db_provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';
import 'core/utils/app_provider_observer.dart';
import 'routes/ventas.dart' deferred as ventas;
import 'routes/inventarios.dart' deferred as inventarios;
import 'routes/servicio_tecnico.dart' deferred as sat;

import 'frame.dart';

import 'core/theme/controllers/settings.dart';
import 'widgets/deferred_widget.dart';

const String appTitle = 'Flex ERP';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ProviderContainer container = ProviderContainer(
    // This observer is used for logging changes in all Riverpod providers.
    observers: <ProviderObserver>[AppProviderObserver()],
  );
  await container.read(keyValueDbProvider).init();

  // if it's not on the web, windows or android, load the accent color
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  setPathUrlStrategy();

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setSize(const Size(1280, 720));
      await windowManager.setMinimumSize(const Size(350, 700));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }
  container.read(keyValueDbListenerProvider);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );

  DeferredWidget.preload(ventas.loadLibrary);
  DeferredWidget.preload(inventarios.loadLibrary);
  DeferredWidget.preload(sat.loadLibrary);
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FluentApp(
      title: appTitle,
      themeMode: ref.watch(Settings.themeModeProvider),
      debugShowCheckedModeBanner: false,
      color: ref.watch(Settings.accentColorProvider),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: ref.watch(Settings.accentColorProvider),
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      theme: ThemeData(
        accentColor: ref.watch(Settings.accentColorProvider),
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      initialRoute: '/',
      routes: {'/': (context) => const FramePage()},
    );
  }
}
