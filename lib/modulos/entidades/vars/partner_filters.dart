import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/utils/filter_model.dart';

const List<FilterMenuItem> clientFilterItems = [
  FilterMenuItem(
    title: 'Activos',
    where: "",
  ),
  FilterMenuItem(
    title: 'Inactivos',
    where: "",
  ),
  FilterMenuItem(
    title: 'Todos',
    icon: FluentIcons.list,
    where: "",
  ),
];

final clientFilterItemsInitial = clientFilterItems.first.title;
