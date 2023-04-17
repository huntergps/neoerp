import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/core/utils/device_info.dart';
import 'package:neo/modulos/widgets/link_text_span.dart';

import '../../core/utils/filter_model.dart';

class FormPageHeader extends ConsumerWidget {
  const FormPageHeader({
    Key? key,
    required this.title,
    required this.number,
    required this.onPressedBack,
    required this.link,
    this.titleParent,
    this.onPressedBackParent,
    this.commandBarItems,
    this.extraInfo,
  }) : super(key: key);

  final List<CommandBarItem>? commandBarItems;

  final String title;
  final String? titleParent;

  final String number;
  final String link;
  final void Function()? onPressedBack;
  final void Function()? onPressedBackParent;
  final Widget? extraInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);
    List<CommandBarItem> myCommandBarItems = commandBarItems ?? [];
    final isPhone = DeviceScreen.isPhone(context);
    String mtitleParent = titleParent ?? '';
    return PageHeader(
      padding: 0,
      // leading:
      title: Row(
        children: [
          IconButton(
            icon: const Icon(FluentIcons.triangle_left12),
            onPressed: onPressedBack,
          ),
          Text(
            '$number  ',
            style: theme.typography.title!
                .apply(color: theme.accentColor, fontSizeFactor: 0.5),
          ),
          RichText(
            text: LinkTextSpan(
              style: theme.typography.title!.apply(
                  color: theme.accentColor,
                  fontSizeFactor: isPhone ? 0.45 : 0.5),
              url: link,
              text: title,
            ),
          ),
          if (mtitleParent.isNotEmpty) ...[
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100, minWidth: 100),
                child: Tooltip(
                  message: mtitleParent,
                  style: const TooltipThemeData(preferBelow: true),
                  child: IconButton(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          FluentIcons.back,
                          color: Colors.blue.lighter,
                          size: 24.0,
                        ),
                        Icon(
                          FluentIcons.assessment_group,
                          color: Colors.blue.lighter,
                          size: 24.0,
                        ),
                      ],
                    ),
                    onPressed: onPressedBackParent,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      commandBar: myCommandBarItems.isEmpty
          ? null
          : CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
              mainAxisAlignment: MainAxisAlignment.end,
              compactBreakpointWidth: 600,
              primaryItems: [
                ...commandBarItems!,
              ],
            ),
    );
  }
}

class ListHeaderPage extends StatelessWidget {
  const ListHeaderPage({
    Key? key,
    required this.icon,
    required this.title,
    this.filterOptions,
    this.filterSecondaryOptions,
    this.filterInitialOption,
    this.filterSecondaryInitialOption,
    this.onChangedSearchText,
    this.onPressedSearch,
    this.onPressedClear,
    this.searchTextController,
    this.onChangedFilterOptions,
    this.onChangedSecundaryFilterOptions,
    this.isPhone = false,
  }) : super(key: key);

  final String title;
  final IconData icon;

  final String? filterInitialOption;
  final List<FilterMenuItem>? filterOptions;
  final String? filterSecondaryInitialOption;
  final List<FilterMenuItem>? filterSecondaryOptions;
  final void Function(String?)? onChangedSearchText;
  final void Function()? onPressedSearch;
  final void Function()? onPressedClear;
  final TextEditingController? searchTextController;
  final void Function(String?)? onChangedFilterOptions;
  final void Function(String?)? onChangedSecundaryFilterOptions;
  final bool isPhone;
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    final filterValuesList = filterOptions ?? [];
    var filterInitialValue = '';
    List<ComboBoxItem<String>> comboLista = [];
    if (filterValuesList.isNotEmpty) {
      filterInitialValue = filterInitialOption ?? filterOptions!.first.title;
      comboLista = filterValuesList.map((e) {
        return ComboBoxItem(
          child: Text(e.title),
          value: e.title,
        );
      }).toList();
    }

    final filterSecondaryValuesList = filterSecondaryOptions ?? [];
    var filterSecondaryInitialValue = '';
    List<ComboBoxItem<String>> comboSecondaryLista = [];
    if (filterSecondaryValuesList.isNotEmpty) {
      filterSecondaryInitialValue =
          filterSecondaryInitialOption ?? filterSecondaryOptions!.first.title;
      comboSecondaryLista = filterSecondaryValuesList.map((e) {
        return ComboBoxItem(
          child: Text(e.title),
          value: e.title,
        );
      }).toList();
    }

    return PageHeader(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
              ),
            ],
          ),
        ),
        title: isPhone
            ? Row(
                children: [
                  Text(title,
                      style:
                          theme.typography.title!.apply(fontSizeFactor: 0.5)),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        DefaultTextStyle(
                          style: theme.typography.body!,
                          child: TextBox(
                            // autofocus: true,
                            onChanged: onChangedSearchText,
                            controller: searchTextController,
                            onEditingComplete: onPressedSearch,
                            prefix: IconButton(
                                icon: const Icon(FluentIcons.search),
                                onPressed: onPressedSearch),
                            suffix: IconButton(
                                icon: const Icon(FluentIcons.clear),
                                onPressed: onPressedClear),
                            placeholder: 'Buscar..',
                          ),
                        ),
                        if (filterSecondaryValuesList.isNotEmpty) ...[
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: 108,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ComboBox<String>(
                                value: filterSecondaryInitialValue,
                                items: comboSecondaryLista,
                                onChanged: onChangedSecundaryFilterOptions,
                                style: theme.typography.caption,
                              ),
                            ),
                          )
                        ],
                        if (filterValuesList.isNotEmpty) ...[
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: 190,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: ComboBox<String>(
                                value: filterInitialValue,
                                items: comboLista,
                                onChanged: onChangedFilterOptions,
                                style: theme.typography.caption,
                              ),
                            ),
                          )
                        ],
                      ],
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Text(title,
                        style:
                            theme.typography.title!.apply(fontSizeFactor: 0.5)),
                  ),
                  if (filterSecondaryValuesList.isNotEmpty) ...[
                    SizedBox(
                      width: 118,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ComboBox<String>(
                          value: filterSecondaryInitialValue,
                          items: comboSecondaryLista,
                          onChanged: onChangedSecundaryFilterOptions,
                          style: theme.typography.caption,
                        ),
                      ),
                    )
                  ],
                  if (filterValuesList.isNotEmpty) ...[
                    SizedBox(
                      width: 203,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ComboBox<String>(
                          value: filterInitialValue,
                          items: comboLista,
                          onChanged: onChangedFilterOptions,
                          style: theme.typography.caption,
                        ),
                      ),
                    )
                  ],
                  Expanded(
                    child: DefaultTextStyle(
                      style: theme.typography.body!,
                      child: TextBox(
                        // autofocus: true,
                        onChanged: onChangedSearchText,
                        controller: searchTextController,
                        onEditingComplete: onPressedSearch,
                        prefix: IconButton(
                            icon: const Icon(FluentIcons.search),
                            onPressed: onPressedSearch),
                        suffix: IconButton(
                            icon: const Icon(FluentIcons.clear),
                            onPressed: onPressedClear),
                        placeholder: 'Buscar..',
                      ),
                    ),
                  ),
                ],
              ));
  }
}
