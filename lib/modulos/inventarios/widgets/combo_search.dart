import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart'
    show
        InputDecoration,
        Material,
        OutlineInputBorder,
        UnderlineInputBorder,
        InputBorder;
import 'package:neo/modulos/common/models/lot_model.dart';
import 'package:neo/modulos/common/models/user_model.dart';
import 'package:neo/modulos/entidades/models/partner_model.dart';

class ComboSearch<T> extends StatelessWidget {
  const ComboSearch({
    super.key,
    this.title,
    this.asyncItems,
    this.selectedItem,
    this.itemBuilder,
    this.itemAsString,
    this.filterFn,
    this.compareFn,
    this.onChanged,
    this.dropKey,
    this.enabled = true,
    this.constraints,
  });
  final String? title;
  final GlobalKey<DropdownSearchState<T>>? dropKey;
  final Future<List<T>> Function(String)? asyncItems;
  final Widget Function(BuildContext, T, bool)? itemBuilder;
  final String Function(T)? itemAsString;
  final bool Function(T, String)? filterFn;
  final bool Function(T, T)? compareFn;
  final void Function(T?)? onChanged;
  final T? selectedItem;
  final bool enabled;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final themeCaption = theme.typography.caption!;
    final titleColor = themeCaption.color!.withOpacity(0.5);
    return ConstrainedBox(
        constraints: constraints ?? const BoxConstraints(maxWidth: 10),
        child: Material(
            child: DropdownSearch<T>(
          enabled: enabled,
          key: dropKey,
          selectedItem: selectedItem,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: theme.typography.caption!.copyWith(
              fontSize: 12,
            ),
            dropdownSearchDecoration: title != null
                ? InputDecoration(
                    isDense: true,
                    labelText: title,
                    labelStyle:
                        themeCaption.copyWith(fontSize: 16, color: titleColor),
                    contentPadding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                    border: InputBorder.none)
                : const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                    border: OutlineInputBorder()),
          ),
          dropdownButtonProps: DropdownButtonProps(
              // visualDensity: VisualDensity.compact,
              isVisible: true,
              padding: const EdgeInsets.all(1.0),
              icon: Icon(
                FluentIcons.search,
                color: theme.accentColor.lightest,
                size: 16,
              )),
          popupProps: PopupProps.dialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$title:',
                style: theme.typography.caption,
              ),
            ),
            searchFieldProps: TextFieldProps(
              style: theme.typography.caption,
              autofocus: true,
            ),
            showSearchBox: true,
            isFilterOnline: true,
            itemBuilder: itemBuilder,
          ),
          asyncItems: asyncItems,

          // selectedItem: clientActual,
          filterFn: filterFn,
          itemAsString: itemAsString,

          compareFn: compareFn,
          onChanged: onChanged,
        )));
  }
}

Widget listadoTransportistas(
  BuildContext context,
  PartnerList? item,
  bool isSelected,
) {
  final theme = FluentTheme.of(context);

  return ConstrainedBox(
    constraints: const BoxConstraints(maxHeight: 150),
    child: Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 10.0, top: 8.0, bottom: 4.0),
      child: Card(
        padding: const EdgeInsets.all(2),
        backgroundColor: theme.micaBackgroundColor,
        borderColor: theme.accentColor.darkest,
        child: ListTile(
          title: Text(
            item!.name ?? '',
            style: theme.typography.body!.copyWith(color: theme.accentColor),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.vat ?? ''),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${item.street}',
                      style: theme.typography.body,
                    ),
                  ),
                  Text(
                    item.city!.toUpperCase(),
                    style: theme.typography.body,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget itemBuilderListadoSeries(
  BuildContext context,
  StockLot? item,
  bool isSelected,
) {
  final theme = FluentTheme.of(context);

  return SingleChildScrollView(
    // padding: const EdgeInsets.all(2.0),
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

    child: Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 10.0, top: 8.0, bottom: 8.0),
      child: Card(
        backgroundColor: theme.micaBackgroundColor,
        padding: const EdgeInsets.all(2),
        borderColor: theme.accentColor.darkest,
        child: ListTile(
          title: Text(
            item?.name ?? '',
            style: theme.typography.body!.copyWith(color: theme.accentColor),
          ),
          // subtitle: Text('Bodega: ${item!.locationIds.toString()}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item!.id.toString()),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Bodega: ${item!.locationIds.toString()}',
                      style: theme.typography.body,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    // ),
  );
}

Widget listadoUsuarios(
  BuildContext context,
  UserList? item,
  bool isSelected,
) {
  final theme = FluentTheme.of(context);

  return ConstrainedBox(
    constraints: const BoxConstraints(maxHeight: 100),
    child: Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 10.0, top: 8.0, bottom: 1.0),
      child: Card(
        padding: const EdgeInsets.all(2),
        backgroundColor: theme.micaBackgroundColor,
        borderColor: theme.accentColor.darkest,
        child: ListTile(
          // selected: isSelected,
          title: Text(
            item?.name ?? '',
            style: theme.typography.body!.copyWith(color: theme.accentColor),
          ),
          subtitle: Text(item?.login?.toString() ?? ''),
        ),
      ),
    ),
  );
}

Widget customBusquedaItemsClients(
    BuildContext context, PartnerList? item, bool isSelected) {
  final theme = FluentTheme.of(context);

  return Container(
    // width: 1400,
    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
    decoration: BoxDecoration(
        border: Border.all(color: theme.accentColor),
        borderRadius: BorderRadius.circular(3),
        color: theme.micaBackgroundColor),
    child: ListTile(
      // isThreeLine: true,
      // selected: isSelected,
      title: Text(
        item?.name ?? '',
        style: theme.typography.caption,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Text(
              //   '${item!.name}: ',
              //   style: theme.typography.caption!.copyWith(fontSize: 10.0),
              // ),
              Text(
                '${item!.vat}',
                style: theme.typography.bodyLarge,
              ),
            ],
          ),
          Text(
            '${item.street}',
            style: theme.typography.body,
          ),
          Text(
            item.city!.toUpperCase(),
            style: theme.typography.body,
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CREDITO',
            style: theme.typography.caption!.copyWith(fontSize: 8.0),
          ),
          Text('\$${item.blockingStage!.toStringAsFixed(3)}'),
        ],
      ),
    ),
  );
}
