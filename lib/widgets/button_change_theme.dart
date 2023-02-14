import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/core/theme/controllers/settings.dart';

class ButtonChangeTheme extends ConsumerWidget {
  const ButtonChangeTheme({
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
