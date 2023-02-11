import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:neo/core/theme/controllers/settings.dart';
import 'package:neo/core/utils/device_info.dart';
import 'package:neo/modulos/ventas/vars/sale_order_filters.dart';
import 'package:neo/modulos/widgets/link_text_span.dart';
import 'package:neo/modulos/widgets/list_header.dart';

import '../../api_repository/sale_order_repository.dart';
import '../../providers/sale_order_form_provider.dart';
import '../../providers/sale_order_list_provider.dart';
import 'seleccionar_despachos.dart';

class HeaderListadoVentas extends ConsumerWidget {
  const HeaderListadoVentas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPhone = DeviceScreen.isPhone(context);

    final TextEditingController searchTextController =
        TextEditingController(text: ref.read(busquedaSaleOrderListProvider));
    return ListHeaderPage(
      isPhone: isPhone,
      icon: FluentIcons.assessment_group,
      title: 'Ordenes de Venta',
      searchTextController: searchTextController,
      filterOptions: saleOrderEstateFilterItems,
      filterInitialOption: ref.watch(busquedaFiltroSaleOrderListProvider),
      onChangedFilterOptions: (value) {
        ref.watch(busquedaFiltroSaleOrderListProvider.notifier).state = value!;
      },
      onChangedSearchText: (textValue) {
        ref.watch(busquedaSaleOrderListProvider.notifier).state = textValue!;
      },
      onPressedClear: () {
        searchTextController.text = '';
        ref.watch(busquedaSaleOrderListProvider.notifier).state = '';
        ref.watch(saleOrderListProvider.notifier).vaciar();
        ref
            .read(totalRegistrosConsultadosSaleOrderListProvider.notifier)
            .state = 0;
        ref.watch(totalRegistrosCargadosSaleOrderListProvider.notifier).state =
            0;
      },
      onPressedSearch: () {
        getRemoteListSaleOrders(context, ref,
            ref.watch(busquedaSaleOrderListProvider.notifier).state,
            listFilterOptions: saleOrderEstateFilterItems,
            listFilter: ref.watch(busquedaFiltroSaleOrderListProvider));
      },
    );
  }
}

class HeaderFormularioVentas extends ConsumerWidget {
  const HeaderFormularioVentas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);

    final registroActual = ref.watch(saleOrderFormProvider);
    final linkPdf =
        '${ref.watch(Settings.serverUrlProvider)}/report/pdf/sale.report_saleorder/${registroActual.id}';
    final link =
        '${ref.watch(Settings.serverUrlProvider)}/web#id=${registroActual.id}&model=sale.order&view_type=form';

    final simpleCommandBarItems = <CommandBarItem>[
      CommandBarBuilderItem(
        builder: (context, mode, w) => Tooltip(
          message: "Visualizar en el navegador!",
          child: w,
        ),
        wrappedItem: CommandBarButton(
          icon: Icon(
            FluentIcons.pdf,
            color: theme.accentColor.darker,
            size: 24.0,
          ),
          onPressed: () {
            launchInBrowserPdf(Uri.parse(linkPdf));
          },
        ),
      ),
      CommandBarBuilderItem(
        builder: (context, mode, w) => Tooltip(
          message: "Refrescar",
          child: w,
        ),
        wrappedItem: CommandBarButton(
          icon: Icon(
            FluentIcons.refresh,
            color: theme.accentColor,
            size: 24.0,
          ),
          onPressed: () {
            var ventaId = registroActual.id?.toInt() ?? 0;
            getRemoteSaleOrder(context, ref, ventaId);
            // launchInBrowserPdf(Uri.parse(linkPdf));
          },
        ),
      ),
    ];
    final despachos = registroActual.pickingIdsData;
    //ref.read(pickingOrderListProvider.notifier).state;
    if (despachos!.isEmpty) {
      final bvacio = CommandBarBuilderItem(
        builder: (context, mode, w) => Tooltip(
          message: "Sin despachos",
          child: w,
        ),
        wrappedItem: CommandBarButton(
          // icon: const Icon(FluentIcons.add),
          label: const Card(
              padding: EdgeInsets.all(4.0), child: Text('SIN DESPACHOS')),
          onPressed: () {},
        ),
      );
      simpleCommandBarItems.add(bvacio);
    } else {
      final despachosBoton = seleccionDespachosBotones(context, ref, despachos);
      simpleCommandBarItems.add(const CommandBarSeparator());
      simpleCommandBarItems.addAll(despachosBoton);
    }

    return FormPageHeader(
      link: link,
      number: "[${registroActual.id}]",
      title: "${registroActual.name}",
      onPressedBack: () {
        ref.read(saleOrderVistaFormularioProvider.notifier).state = false;
      },
      commandBarItems: simpleCommandBarItems,
    );
  }
}
