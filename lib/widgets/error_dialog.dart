import 'package:fluent_ui/fluent_ui.dart';

void showErrorDialog(BuildContext context, String title, String msn) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Text(
        msn,
      ),
      actions: [
        Button(
          child: const Text('Cerrar'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

void showQuestion(BuildContext context, String title, String msn,
    void Function()? onConfirmPressed) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Text(
        msn,
      ),
      actions: [
        FilledButton(
          child: const Text('Confirmar'),
          onPressed: onConfirmPressed,
        ),
        Button(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

void showChooseDespacho(
    BuildContext context, String title, Widget content) async {
  final theme = FluentTheme.of(context);
  final themeTitle = theme.typography.title!;

  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(
        title,
        style: themeTitle.apply(color: theme.accentColor, fontSizeFactor: 0.6),
      ),
      content: content,
      actions: [
        Button(
          child: const Text('Cerrar'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
