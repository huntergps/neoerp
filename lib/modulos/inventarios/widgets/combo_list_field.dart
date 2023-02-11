import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComboListado extends ConsumerWidget {
  const ComboListado({
    super.key,
    required this.selected,
    required this.values,
    required this.onChanged,
  });
  final String? selected;
  final Map<String, String> values;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Color selectedColor = 'Green';
    final theme = FluentTheme.of(context);

    // return DefaultTextStyle(
    //   style: const TextStyle(fontSize: 8),
    //   child:
    return ComboBox<String>(
      style: theme.typography.caption,
      value: selected,
      items: values.entries.map((e) {
        return ComboBoxItem(
          child: Text(e.value),
          value: e.key,
        );
      }).toList(),
      onChanged: onChanged,
    );
    // );
  }
}
