import 'package:fluent_ui/fluent_ui.dart' hide Page;

import '../../../../widgets/app_logo_text.dart';

class MenuHeaderSession extends StatelessWidget {
  const MenuHeaderSession({
    Key? key,
    required this.odooDb,
  }) : super(key: key);

  final String odooDb;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const AppLogo(
                constraints: BoxConstraints(maxHeight: 40),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  $odooDb',
                    style: theme.typography.caption!.copyWith(
                        color: theme.accentColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 10),
                  ),
                  const AppLogoText(
                    constraints: BoxConstraints(maxHeight: 27),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
