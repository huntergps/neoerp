import 'package:fluent_ui/fluent_ui.dart';

class FilterMenuItem {
  const FilterMenuItem({
    required this.title,
    required this.where,
    this.icon,
    this.children = const [],
    // this.onPressed,
  });
  final String title;
  final IconData? icon;
  final String where;
  final List<FilterMenuItem> children;
  // final VoidCallback? onPressed;
}

String darFiltro(List<FilterMenuItem>? filterOptions, String value) {
  String filtroStr = "";
  final filterValuesList = filterOptions ?? [];
  if (filterValuesList.isNotEmpty) {
    filtroStr = filterValuesList
        .firstWhere((e) => e.title.toLowerCase() == value.toLowerCase())
        .where;
  }
  return filtroStr;
}
