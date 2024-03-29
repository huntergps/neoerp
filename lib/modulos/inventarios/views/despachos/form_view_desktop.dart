import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/common/models/location_model.dart';

import 'package:neo/modulos/entidades/api_repository/partner_repository.dart';
import 'package:neo/providers/dio_provider.dart';
import 'package:neo/widgets/error_dialog.dart';
import 'package:neo/widgets/text_label.dart';

import '../../../common/models/user_model.dart';
import '../../../entidades/models/partner_model.dart';
import '../../api_repository/dar_tipo_provider.dart';
import '../../api_repository/move_repository.dart';
import '../../api_repository/picking_order_repository.dart';
import '../../models/picking_model.dart';
import '../../providers/picking_order_form_provider.dart';
import '../../vars/picking_list_fields.dart';
import '../../widgets/combo_list_field.dart';
import '../../widgets/combo_search.dart';

class DespachoMainInfoDesktop extends ConsumerWidget {
  const DespachoMainInfoDesktop({this.registroActual, Key? key})
      : super(key: key);
  final PickingOrder? registroActual;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);

    var ventaId = registroActual!.saleId?.toInt() ?? 0;

    final clienteActual = registroActual!.partnerVentaIdData != null
        ? registroActual!.partnerVentaIdData!.isEmpty
            ? PartnerList(id: 0, name: '', street: '', city: '')
            : registroActual!.partnerVentaIdData!.first
        : PartnerList(id: 0, name: '', street: '', city: '');
    // print(clienteActual.name);
    final UserList userActual = registroActual!.userIdData != null
        ? registroActual!.userIdData!.isEmpty
            ? UserList(id: 0, name: '', login: '', email: '')
            : registroActual!.userIdData!.first
        : UserList(id: 0, name: '', login: '', email: '');

    final LocationIdData bodegaActual = registroActual!.locationIdData != null
        ? registroActual!.locationIdData!.isEmpty
            ? LocationIdData(id: 0, name: '')
            : registroActual!.locationIdData!.first
        : LocationIdData(id: 0, name: '');

    final colorFondo = getColorAprobado(context, registroActual!.state);
    final colorLinea =
        getColorAprobado(context, registroActual!.state, fondo: false);
    final modoEdicion = ref.watch(pickingOrderEditarProvider);
    return Mica(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  TextLabel(
                      width: 100,
                      widthValue: 100,
                      label: 'Ruc',
                      value: '${registroActual!.clienteRuc}'),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: TextLabel(
                        width: 100,
                        widthValue: 900,
                        label: 'Entidad',
                        value: '${registroActual!.clienteName}'),
                  ),
                  if (registroActual!.state == 'draft') ...[
                    Tooltip(
                      message: 'Preparar Despacho',
                      style: const TooltipThemeData(preferBelow: true),
                      child: IconButton(
                        icon: Icon(
                          FluentIcons.completed,
                          color: Colors.blue.lighter,
                          size: 24.0,
                        ),
                        onPressed: () {
                          var despachoId = registroActual!.id?.toInt() ?? 0;
                          despachoRefreshEstadoFacturas(context, ref,
                              despachoId, 'despachos_preparar_productos');
                        },
                      ),
                    ),
                  ],
                  if (registroActual!.state == 'confirmed') ...[
                    Tooltip(
                      message: 'Verificar Despacho',
                      style: const TooltipThemeData(preferBelow: true),
                      child: IconButton(
                        icon: Icon(
                          FluentIcons.trigger_approval,
                          color: Colors.blue.lighter,
                          size: 24.0,
                        ),
                        onPressed: () {
                          var despachoId = registroActual!.id?.toInt() ?? 0;
                          despachoRefreshEstadoFacturas(context, ref,
                              despachoId, 'despachos_comprobar_existencias');
                        },
                      ),
                    ),
                  ],
                  if ((registroActual!.state == 'confirmed') ||
                      (registroActual!.state == 'assigned')) ...[
                    if (modoEdicion) ...[
                      const SizedBox(width: 8),
                      Tooltip(
                        message: 'Validar Despacho',
                        style: const TooltipThemeData(preferBelow: true),
                        child: IconButton(
                          icon: Icon(
                            FluentIcons.change_entitlements,
                            color: Colors.green,
                            size: 24.0,
                          ),
                          onPressed: () {
                            var despachoId = registroActual!.id?.toInt() ?? 0;
                            final pend =
                                darMoveListProviderNotifier(ref).getRegistros();
                            final pp = pend.fold<double>(
                                0,
                                (preVal, e) =>
                                    preVal + e.reservedAvailivity!.toDouble());
                            final pp2 = pend.fold<double>(
                                0,
                                (preVal, e) =>
                                    preVal + e.productUomQty!.toDouble());
                            if (pp < pp2) {
                              showQuestion(context, 'Validar',
                                  'El despacho esta incompleto. Si continua se crearan despachos parciales',
                                  () {
                                despachoRefreshEstadoFacturas(context, ref,
                                    despachoId, 'despachos_validar_reservas');
                                Navigator.pop(context);
                              });
                            } else {
                              despachoRefreshEstadoFacturas(context, ref,
                                  despachoId, 'despachos_validar_reservas');
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                  if (registroActual!.state == 'assigned') ...[
                    if (modoEdicion) ...[
                      const SizedBox(width: 8),
                      const SizedBox(width: 4),
                      Tooltip(
                        message: 'Anular reserva de Despacho',
                        style: const TooltipThemeData(preferBelow: true),
                        child: IconButton(
                          icon: Icon(
                            FluentIcons.cancel,
                            color: theme.borderInputColor,
                            size: 24.0,
                          ),
                          onPressed: () {
                            ref
                                .read(pickingOrderEditarProvider.notifier)
                                .state = true;

                            var despachoId = registroActual!.id?.toInt() ?? 0;
                            despachoRefreshEstadoFacturas(context, ref,
                                despachoId, 'despachos_anular_reservas');
                            // launchInBrowserPdf(Uri.parse(linkPdf));
                          },
                        ),
                      ),
                    ]
                  ],
                  const SizedBox(width: 4),
                  Card(
                    padding: const EdgeInsets.only(
                        left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                    borderColor: colorLinea,
                    backgroundColor: colorFondo,
                    child: Text(
                      statePickingOrderField[registroActual!.state]!
                          .toUpperCase(),
                      style: theme.typography.subtitle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      // if (modoEdicion) ...[
                      //   TextLabel(
                      //       width: 280,
                      //       widthValue: 280,
                      //       label: 'Bod.Origen',
                      //       value: '${registroActual!.locationName}'),
                      // ] else ...[
                      if (registroActual!.state == 'draft' ||
                          registroActual!.state == 'waiting' ||
                          registroActual!.state == 'confirmed') ...[
                        ComboSearch<LocationIdData>(
                          // enabled: (registroActual!.state == 'draft' ||
                          //     registroActual!.state == 'waiting' ||
                          //     registroActual!.state == 'confirmed'),
                          constraints: const BoxConstraints(
                            maxWidth: 280,
                            maxHeight: 36,
                          ),
                          title: 'Bod.Origen',
                          selectedItem: bodegaActual,
                          asyncItems: (String busqueda) async {
                            return getDataComboBodegas(ref, busqueda);
                          },
                          filterFn: (bodega, filter) {
                            return (bodega.name!
                                .toLowerCase()
                                .contains(filter.toLowerCase()));
                          },
                          itemBuilder: listadoBodegas,
                          itemAsString: (LocationIdData? data) {
                            return '${data?.name}';
                          },
                          onChanged: (LocationIdData? data) {
                            showQuestion(context, 'Cambiar Bodega',
                                'Esta seguro que desea cambiar de bodega?', () {
                              Navigator.pop(context);
                              modificarMoveDesdeFormulario(
                                  context,
                                  ref,
                                  registroActual!.copyWith(
                                    locationId: data!.id,
                                    locationName: data.name,
                                    locationIdData: [data],
                                  ));
                              var despachoId = registroActual!.id!.toInt();
                              final ok = cambiarBodegaDespacho(
                                  context, ref, despachoId);
                              ok.then((resultadoRemoto) {
                                if (resultadoRemoto == false) {
                                  getRemoteRecordDespacho(
                                      context, ref, despachoId);
                                }
                              });
                            });
                          },
                          compareFn: (i, s) => i.isEqual(s),
                        ),
                      ] else ...[
                        TextLabel(
                            width: 280,
                            widthValue: 280,
                            label: 'Bod.Origen',
                            value: '${registroActual!.locationName}'),
                      ],
                      // ],
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextLabel(
                            width: 100,
                            widthValue: 200,
                            label: 'Bod. Destino',
                            value: '${registroActual!.locationDestName}'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextLabel(
                            width: 100,
                            widthValue: 200,
                            label: 'Operacion',
                            value: '${registroActual!.pickingTypeName}'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextLabel(
                            width: 100,
                            widthValue: 300,
                            label: 'Origen',
                            value: '${registroActual!.origin}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      if (modoEdicion) ...[
                        TextLabel(
                            // fontSizeValue: 11,
                            width: 280,
                            widthValue: 280,
                            label: 'Responsable',
                            value: '${registroActual!.userName}'),
                      ] else ...[
                        ComboSearch<UserList>(
                          constraints: const BoxConstraints(
                            maxWidth: 280,
                            maxHeight: 36,
                          ),
                          title: 'Responsable',
                          selectedItem: userActual,
                          asyncItems: (String busqueda) async {
                            return getDataComboUsuario(ref, busqueda);
                          },
                          filterFn: (client, filter) {
                            return (client.name!
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())) ||
                                (client.login!
                                    .toLowerCase()
                                    .contains(filter.toLowerCase()));
                          },
                          itemBuilder: listadoUsuarios,
                          itemAsString: (UserList? data) {
                            return '${data?.name}';
                          },
                          onChanged: (UserList? data) {
                            modificarMoveDesdeFormulario(
                                context,
                                ref,
                                registroActual!.copyWith(
                                  userId: data!.id,
                                  userName: data.name,
                                  userIdData: [data],
                                ));
                          },
                          compareFn: (i, s) => i.isEqual(s),
                        )
                      ],
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextLabel(
                            width: 100,
                            widthValue: 200,
                            label: 'Fecha prevista',
                            value: '${registroActual!.scheduledDate}'),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        flex: 2,
                        child: TextLabel(
                            width: 100,
                            widthValue: 200,
                            label: 'Fecha efectiva',
                            value: '${registroActual!.dateDone}'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            if (ventaId > 0) ...[
              Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (modoEdicion) ...[
                          TextLabel(
                              width: 200,
                              widthValue: 200,
                              label: 'Tipo de Despacho',
                              value:
                                  '${stateTypePickingOrderField[registroActual!.stateType]}'),
                        ] else ...[
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 250, minWidth: 150),
                            child: ComboListado(
                              selected: registroActual!.stateType,
                              values: stateTypePickingOrderField,
                              onChanged: (valor) {
                                modificarMoveDesdeFormulario(context, ref,
                                    registroActual!.copyWith(stateType: valor));
                              },
                            ),
                          )
                        ],
                        const SizedBox(width: 8),
                        if (modoEdicion) ...[
                          TextLabel(
                              width: 130,
                              widthValue: 130,
                              label: 'Ruc',
                              value: '${registroActual!.clienteVentaRuc}'),
                        ] else ...[
                          ComboSearch<PartnerList>(
                            constraints: const BoxConstraints(
                              maxWidth: 149,
                              maxHeight: 34,
                            ),

                            title: 'Ruc',
                            selectedItem: clienteActual,
                            asyncItems: (String busqueda) async {
                              return getDataComboTransportista(ref, busqueda);
                            },
                            filterFn: (client, filter) {
                              return (client.name!
                                      .toLowerCase()
                                      .contains(filter.toLowerCase())) ||
                                  (client.vat!
                                      .toLowerCase()
                                      .contains(filter.toLowerCase()));
                            },
                            itemBuilder:
                                listadoTransportistas, //listadoTransportistas,
                            itemAsString: (PartnerList? data) {
                              return '${data?.vat}';
                            },
                            onChanged: (PartnerList? data) {
                              modificarMoveDesdeFormulario(
                                  context,
                                  ref,
                                  registroActual!.copyWith(
                                    clienteVentaRuc: data!.vat,
                                    clienteVentaName: data.name,
                                    partnerVentaId: data.id,
                                    partnerVentaIdData: [data],
                                  ));
                            },
                            compareFn: (i, s) => i.isEqual(s),
                          )
                        ],
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: TextLabel(
                              width: 100,
                              widthValue: 900,
                              label: 'Retirado por',
                              value: '${registroActual!.clienteVentaName}'),
                        ),
                        Expanded(
                          child: Button(
                            onPressed: () {
                              var despachoId = registroActual!.id?.toInt() ?? 0;
                              despachoRefreshEstadoFacturas(context, ref,
                                  despachoId, 'despachos_verificar_facturas');
                            },
                            // padding: const EdgeInsets.all(1.0),
                            child: TextLabel(
                                labelTextAlign: TextAlign.left,
                                valueTextAlign: TextAlign.left,
                                width: 170,
                                widthValue: 170,
                                label: 'Estado Factura',
                                value: '${registroActual!.estadoFactura}'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Expanded(
                          // flex: 2,
                          child: TextLabel(
                              width: 50,
                              widthValue: 580,
                              label: 'Direccion',
                              value:
                                  '${clienteActual.street}, ${clienteActual.city}'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }
}

Color? getColorAprobado(BuildContext context, String? state,
    {bool fondo = true}) {
  final theme = FluentTheme.of(context);
  Color? color;
  switch (state) {
    case 'draft':
      {
        color = fondo ? Colors.red.lightest : Colors.red.darkest;
      }
      break;

    case 'done':
      {
        color = fondo ? Colors.green.lightest : Colors.green.darkest;
      }
      break;
    case 'confirmed':
      {
        color = fondo ? Colors.blue.lightest : Colors.blue.darkest;
      }
      break;
    case 'assigned':
      {
        color = fondo ? Colors.blue.lightest : Colors.blue.darkest;
      }
      break;
    case 'cancel':
      {
        color = fondo ? Colors.orange.lightest : Colors.orange.darkest;
      }
      break;
    default:
      {
        color = fondo
            ? theme.scaffoldBackgroundColor
            : theme.typography.title!.color;
      }
      break;
  }
  return color;
}
// 'draft': 'Borrador',
// 'confirmed': 'Espera',
// 'assigned': 'Preparado',
// 'done': 'Hecho',
// 'approval': 'En esamblaje',
// 'approved': 'Envio Interno',
// 'rejected': 'Envio Externo',
// 'cancel': 'Cancelado',
// 'delivered': 'Entregado',
