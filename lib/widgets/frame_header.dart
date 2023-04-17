import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import '../core/settings/controllers/settings.dart';
import 'menu_header.dart';

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
          color.defaultBrushFor(theme.brightness);

          return LinearGradient(
            colors: [
              color,
              color,
            ],
          ).createShader(rect);
        },
        child: MenuHeaderSession(odooDb: ref.watch(Settings.serverDBProvider)),
      ),
    );
  }
}
