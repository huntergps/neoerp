import 'package:fluent_ui/fluent_ui.dart';

class AppLogoText extends StatelessWidget {
  const AppLogoText({Key? key, this.constraints, this.color}) : super(key: key);
  final BoxConstraints? constraints;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    Widget img = Image.asset(
      "assets/logo_letras.png",
      fit: BoxFit.contain,
      color: color ?? theme.accentColor,
      filterQuality: FilterQuality.high,
    );
    return (constraints == null)
        ? img
        : ConstrainedBox(constraints: constraints!, child: img);
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, this.constraints, this.color}) : super(key: key);
  final BoxConstraints? constraints;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    Widget img = Image.asset(
      "assets/logo.png",
      fit: BoxFit.contain,
      color: color ?? theme.accentColor,
      filterQuality: FilterQuality.high,
    );
    return (constraints == null)
        ? img
        : ConstrainedBox(constraints: constraints!, child: img);
  }
}
