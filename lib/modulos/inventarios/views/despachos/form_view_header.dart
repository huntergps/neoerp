import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:neo/core/settings/controllers/settings.dart';
import 'package:neo/modulos/widgets/link_text_span.dart';
import 'package:neo/modulos/widgets/list_header.dart';
import 'package:neo/widgets/error_dialog.dart';
import 'package:printing/printing.dart';

import '../../../../providers/providers_general.dart';
import '../../../ventas/providers/sale_order_form_provider.dart';
import '../../api_repository/picking_order_repository.dart';
import '../../models/picking_model.dart';
import '../../providers/picking_order_list_provider.dart';
import '../../providers/picking_order_form_provider.dart';

class HeaderListadoDespachos extends ConsumerWidget {
  const HeaderListadoDespachos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchTextController =
        TextEditingController(text: ref.read(busquedaPickingOrderListProvider));
    return ListHeaderPage(
      icon: FluentIcons.assessment_group,
      title: 'Despachos de Venta',
      searchTextController: searchTextController,
      onChangedSearchText: (textValue) {
        ref.watch(busquedaPickingOrderListProvider.notifier).state = textValue!;
      },
      onPressedClear: () {
        searchTextController.text = '';

        ref.watch(busquedaPickingOrderListProvider.notifier).state = '';
        ref.watch(pickingOrderListProvider.notifier).vaciar();
        ref
            .read(totalRegistrosConsultadosPickingOrderListProvider.notifier)
            .state = 0;
        ref
            .watch(totalRegistrosCargadosPickingOrderListProvider.notifier)
            .state = 0;
      },
      onPressedSearch: () {
        getRemoteListPickingOrders(context, ref,
            ref.watch(busquedaPickingOrderListProvider.notifier).state);
      },
    );
  }
}

class HeaderFormularioDespachos extends ConsumerWidget {
  const HeaderFormularioDespachos({
    super.key,
    required this.registroActual,
  });

  final PickingOrder registroActual;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);

    // final PickingOrder registroActual = ref.watch(pickingOrderFormProvider);
    final linkPdf =
        '${ref.watch(Settings.serverUrlProvider)}/report/pdf/stock.report_picking/${registroActual.id}';
    final link =
        '${ref.watch(Settings.serverUrlProvider)}/web#id=${registroActual.id}&model=stock.picking&view_type=form';
    final modoEdicion = ref.watch(pickingOrderEditarProvider);

    final simpleCommandBarItems = <CommandBarItem>[
      // if (registroActual.state == 'assigned') ...[
      //   CommandBarBuilderItem(
      //     builder: (context, mode, w) => Tooltip(
      //       message: "Anular Reserva",
      //       child: w,
      //     ),
      //     wrappedItem: CommandBarButton(
      //       icon: Icon(
      //         FluentIcons.processing_cancel,
      //         color: theme.borderInputColor,
      //         size: 24.0,
      //       ),
      //       onPressed: () {
      //         ref.read(pickingOrderEditarProvider.notifier).state = true;

      //         var despachoId = registroActual.id?.toInt() ?? 0;
      //         despachoRefreshEstadoFacturas(
      //             context, ref, despachoId, 'despachos_anular_reservas');
      //         // launchInBrowserPdf(Uri.parse(linkPdf));
      //       },
      //     ),
      //   ),
      // ],
      // if (registroActual.state == 'confirmed') ...[
      //   CommandBarBuilderItem(
      //     builder: (context, mode, w) => Tooltip(
      //       message: "Verificar",
      //       child: w,
      //     ),
      //     wrappedItem: CommandBarButton(
      //       icon: Icon(
      //         FluentIcons.trigger_approval,
      //         color: Colors.blue.lighter,
      //         size: 24.0,
      //       ),
      //       onPressed: () {
      //         var despachoId = registroActual.id?.toInt() ?? 0;
      //         despachoRefreshEstadoFacturas(
      //             context, ref, despachoId, 'despachos_comprobar_existencias');
      //       },
      //     ),
      //   ),
      // ],
      if (registroActual.state == 'assigned') ...[
        if (modoEdicion == true) ...[
          // CommandBarBuilderItem(
          //   builder: (context, mode, w) => Tooltip(
          //     message: "Validar",
          //     child: w,
          //   ),
          //   wrappedItem: CommandBarButton(
          //     icon: Icon(
          //       FluentIcons.account_activity,
          //       color: Colors.green,
          //       size: 24.0,
          //     ),
          //     onPressed: () {
          //       var despachoId = registroActual.id?.toInt() ?? 0;
          //       final pend = darMoveListProviderNotifier(ref).getRegistros();
          //       final pp = pend.fold<double>(0,
          //           (preVal, e) => preVal + e.reservedAvailivity!.toDouble());
          //       final pp2 = pend.fold<double>(
          //           0, (preVal, e) => preVal + e.productUomQty!.toDouble());
          //       if (pp < pp2) {
          //         showQuestion(context, 'Validar',
          //             'El despacho esta incompleto. Si continua se crearan despachos parciales',
          //             () {
          //           despachoRefreshEstadoFacturas(
          //               context, ref, despachoId, 'despachos_validar_reservas');
          //           Navigator.pop(context);
          //         });
          //       } else {
          //         despachoRefreshEstadoFacturas(
          //             context, ref, despachoId, 'despachos_validar_reservas');
          //       }
          //     },
          //   ),
          // ),
          const CommandBarSeparator(),
          // CommandBarSeparator(),
          CommandBarBuilderItem(
            builder: (context, mode, w) => Tooltip(
              message: "Editar",
              child: w,
            ),
            wrappedItem: CommandBarButton(
              icon: Icon(
                FluentIcons.edit,
                color: Colors.green,
                size: 24.0,
              ),
              onPressed: () {
                ref.watch(pickingOrderEditarProvider.notifier).state = false;
              },
            ),
          ),
        ] else ...[
          CommandBarBuilderItem(
            builder: (context, mode, w) => Tooltip(
              message: "Aceptar",
              child: w,
            ),
            wrappedItem: CommandBarButton(
              icon: Icon(
                FluentIcons.accept_medium,
                color: Colors.green.light,
                size: 24.0,
              ),
              onPressed: () {
                // if (registroActual.userId!.toInt() == 0) {
                //   showErrorDialog(context, 'Error',
                //       'Se debe especificar al usuario responsable!!');
                // } else {
                var despachoId = registroActual.id!.toInt();
                setRemoteRecordDespacho(context, ref, despachoId);
                // }
              },
            ),
          ),
          CommandBarBuilderItem(
            builder: (context, mode, w) => Tooltip(
              message: "Cancelar",
              child: w,
            ),
            wrappedItem: CommandBarButton(
              icon: Icon(
                FluentIcons.cancel,
                color: theme.borderInputColor,
                size: 24.0,
              ),
              onPressed: () {
                ref.read(pickingOrderEditarProvider.notifier).state = true;
                var despachoId = registroActual.id?.toInt() ?? 0;
                getRemoteRecordDespacho(context, ref, despachoId);
              },
            ),
          ),
        ]
      ],
      if (modoEdicion == true) ...[
        const CommandBarSeparator(),
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
            onPressed: () async {
              var despachoId = registroActual.id?.toInt() ?? 0;
              final base64PDF =
                  await getDespachoReport(context, ref, despachoId);
              if (base64PDF != null) {
                final bytes = base64.decode(base64PDF);
                await Printing.layoutPdf(
                  onLayout: (_) => bytes,
                );
              }
              // launchInBrowserPdf(Uri.parse(linkPdf));
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
              var despachoId = registroActual.id?.toInt() ?? 0;
              getRemoteRecordDespacho(context, ref, despachoId);
            },
          ),
        ),
      ],
    ];
    final ventaActualFormulario = ref.watch(saleOrderFormProvider);
    return FormPageHeader(
      link: link,
      number: "[${registroActual.id}]",
      title: "${registroActual.name}",
      titleParent: (ref.watch(tipoPantalla) == "sale_despacho_form")
          ? "Regresar a Listado de Ventas "
          : "",
      // title: "[${registroActual.id}] ${registroActual.name}",
      onPressedBackParent: () {
        if (ref.watch(tipoPantalla) == "sale_despacho_form") {
          ref.read(tipoPantalla.notifier).state = "sale_form";
          ref.read(saleOrderVistaFormularioProvider.notifier).state = false;
        }
      },
      onPressedBack: () {
        if (ref.watch(tipoPantalla) == "sale_despacho_form") {
          ref.read(tipoPantalla.notifier).state = "sale_form";
        } else {
          ref.read(pickingOrderVistaFormularioProvider.notifier).state = false;
        }
      },
      commandBarItems: simpleCommandBarItems,
    );
  }
}
