import 'package:fluent_ui/fluent_ui.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: theme.accentColor.lightest,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.body?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: theme.borderInputColor,
                ),
              ),
              Text(
                subtitle,
                style: theme.typography.caption?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: theme.borderInputColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SessionItemSimple extends StatelessWidget {
  const SessionItemSimple({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: 28,
            color: theme.accentColor.lightest,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: theme.typography.body?.copyWith(
              fontWeight: FontWeight.w300,
              color: theme.borderInputColor,
            ),
          ),
        ],
      ),
    );
  }
}
