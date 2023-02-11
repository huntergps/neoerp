import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/login/dio_login_provider.dart';
import 'package:neo/widgets/plataforma.dart';
import 'package:window_manager/window_manager.dart';

import 'core/utils/providers_generales.dart';
import 'core/theme/controllers/settings.dart';
import 'modulos/login.dart';
import 'menu_options.dart';
import 'menu_side.dart';
import 'providers/providers_general.dart';

import 'routes/ventas.dart' deferred as ventas;
import 'routes/inventarios.dart' deferred as inventarios;
import 'routes/servicio_tecnico.dart' deferred as sat;

class FramePage extends ConsumerStatefulWidget {
  const FramePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FramePageState();
}

class _FramePageState extends ConsumerState<FramePage> with WindowListener {
  bool value = false;

  // int index = 0;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final String sessionId = ref.watch(Settings.sessionIdProvider);
      final PaneDisplayMode displayMode = ref.watch(displayModeProvider);
      final String miTitle =
          "$appTitle::${ref.watch(Settings.serverUrlProvider)}/${ref.watch(Settings.serverDBProvider)}";
      return NavigationView(
        key: viewKey,
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: () {
            if (kIsWeb) {
              return Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(miTitle),
              );
            }
            return DragToMoveArea(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(miTitle),
              ),
            );
          }(),
          actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            if (!kIsWeb) ...[
              if (PlatformInfo.isDesktopOS()) ...[
                WindowButtons(),
              ]
            ],
          ]),
        ),
        pane: NavigationPane(
          selected: ref.watch(indexMenuProvider),
          onChanged: (i) {
            setState(() {
              // index = i;
              ref.read(indexMenuProvider.notifier).state = i;
            });
          },
          header: const FrameHeader(),
          displayMode: displayMode,
          items: sessionId.isEmpty
              ? [
                  PaneItem(
                    icon: const Icon(FluentIcons.my_network),
                    title: const Text('Ingresar'),
                    body: const LoginPage(),
                  ),
                ]
              : originalItems,
          footerItems: footerItems,
        ),
      );
    });
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Desea cerrar el App'),
            content:
                const Text('¿Está seguro de que desea cerrar esta ventana?'),
            actions: [
              FilledButton(
                child: const Text('Si'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class FrameHeader extends ConsumerWidget {
  const FrameHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);

    return SizedBox(
      height: kOneLineTileHeight,
      child: ShaderMask(
        shaderCallback: (rect) {
          final AccentColor color = ref.watch(Settings.accentColorProvider);
          color.resolveFromReverseBrightness(
            theme.brightness,
            level: theme.brightness == Brightness.light ? 0 : 2,
          );
          return LinearGradient(
            colors: [
              color,
              color,
            ],
          ).createShader(rect);
        },
        child: MenuHeader(odooDb: ref.watch(Settings.serverDBProvider)),
      ),
    );
  }
}

class BotonTema extends ConsumerWidget {
  const BotonTema({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appTheme = ref.read(appThemeProvider.notifier);
    // final ThemeMode mode = ref.watch(Settings.themeModeProvider);

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8.0),
      child: ToggleSwitch(
        content: const Text('Modo Oscuro'),
        checked: FluentTheme.of(context).brightness.isDark,
        onChanged: (v) {
          if (v) {
            ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.dark);
          } else {
            ref.read(Settings.themeModeProvider.notifier).set(ThemeMode.light);
          }
        },
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
