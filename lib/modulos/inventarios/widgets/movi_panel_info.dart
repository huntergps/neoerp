import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/common/models/lot_model.dart';
import 'package:neo/modulos/inventarios/models/stock_move_line_list_model.dart';
import 'package:neo/modulos/inventarios/providers/picking_order_form_provider.dart';
import 'package:neo/modulos/inventarios/widgets/combo_nro.dart';
import 'package:neo/modulos/inventarios/widgets/combo_search.dart';
import 'package:neo/modulos/widgets/utils.dart';
import 'package:neo/widgets/text_label.dart';

import '../../entidades/api_repository/partner_repository.dart';
import '../api_repository/dar_tipo_provider.dart';
import '../api_repository/move_line_repository.dart';
import '../models/stock_move_list_model.dart';
import '../vars/picking_order_global_vars.dart';
import '../views/despachos/move_line_list.dart';

class PanelMoveInfo extends ConsumerWidget {
  const PanelMoveInfo({
    Key? key,
    required this.move,
    // this.titleColor,
    // this.fondoTitleColor,
  }) : super(key: key);

  final StockMoveList move;
  // final Color? fondoTitleColor;
  // final Color? titleColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);
    final bool limiteLineas =
        move.reservedAvailivity!.toDouble() >= move.productUomQty!.toDouble();
    final bool esPorSerie = move.productTracking.toString() == 'serial';
    // print(move.locationId);
    final productId = move.productId!.toInt();
    final locationId = revisaVaciosInt(move.locationId);
    final StockLot loteActual =
        darLoteActualFormularioProviderNotifier(ref).state;
    final StockMoveLineList lineaActual =
        darMoveLineActualFormularioProviderNotifier(ref).state;

    final modoEdicion = ref.watch(pickingOrderEditarProvider);

    // print(move.productId);
    return Card(
        // backgroundColor: Colors.blue,

        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 26,
                    color: theme.accentColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(0.0),
                    child: const Text(
                      'INFORMACION DEL MOVIMIENTO',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Mica(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Flexible(
                          child: TextLabel(
                              width: 50,
                              widthValue: 60,
                              label: 'ID',
                              value: '${move.id}'),
                        ),
                        Flexible(
                          child: TextLabel(
                              width: 140,
                              widthValue: 140,
                              label: 'Codigo',
                              value: '${move.productCode}'),
                        ),
                        Flexible(
                          child: TextLabel(
                              width: 140,
                              widthValue: 140,
                              label: 'Unidad',
                              value: '${move.productUomName}'),
                        ),
                        Flexible(
                          child: TextLabel(
                              width: 90,
                              widthValue: 90,
                              label: 'Seguimiento',
                              value: '${move.productTracking}'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Flexible(
                          child: TextLabel(
                              width: 50,
                              widthValue: 360,
                              fontSizeValue: 14,
                              label: 'Detalle',
                              value: '${move.productIdName}'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Flexible(
                          child: TextLabel(
                              width: 50,
                              widthValue: 360,
                              label: 'Cantidad',
                              value: '${move.productUomQty}'),
                        ),
                        Flexible(
                          child: TextLabel(
                              width: 50,
                              widthValue: 360,
                              label: 'Hecho',
                              value: '${move.qtyDone}'),
                        ),
                        Flexible(
                          child: TextLabel(
                              width: 50,
                              widthValue: 360,
                              label: 'Reservado',
                              value: '${move.reservedAvailivity}'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    if (modoEdicion == false) ...[
                      if (esPorSerie == false) ...[
                        Row(
                          children: [
                            TextLabel(
                                width: 50,
                                widthValue: 100,
                                label: 'Producto ID',
                                value: '$productId'),
                            const SizedBox(width: 8.0),
                            // NumberChoose(
                            //   constraints:
                            //       BoxConstraints(maxHeight: 40, maxWidth: 200),
                            //   inicio: 0,
                            //   fin: move.productUomQty!.toDouble(),
                            //   actual: move.reservedAvailivity!.toDouble(),
                            // ),
                            SizedBox(
                              width: 90,
                              child: ComboNumero(
                                inicio: 0,
                                fin: move.productUomQty!.toDouble(),
                                actual: move.reservedAvailivity!.toDouble(),
                                onChanged: (valor) {
                                  final newValor = valor!.toDouble();
                                  if (newValor < 0 ||
                                      newValor >
                                          move.productUomQty!.toDouble()) {
                                    throw UnsupportedError(
                                      'El valor solo puede estar en el rango: 0.0 y ${move.productUomQty!.toDouble()}',
                                    );
                                  }
                                  // print(lineaActual.toJson());
                                  // final newLine = lineaActual.id==null
                                  if (lineaActual.id == null) {
                                    agregarAListadoDeMoveLine(
                                      context,
                                      ref,
                                      StockMoveLineList(
                                        id: 0,
                                        lotId: 0,
                                        lotName: '',
                                        lotIdName: '',
                                        productUomQty: 1.0,
                                        qtyDone: 0.0,
                                        productTracking: move.productTracking,
                                        locationId: move.locationId,
                                        locationDestId: move.locationDestId,
                                        productUomId: move.productUom,
                                      ),
                                    );
                                  } else {
                                    modificarMoveLine(
                                        context,
                                        ref,
                                        lineaActual.copyWith(
                                            productUomQty: newValor));
                                  }

                                  try {} catch (e) {
                                    debugPrint('$e');
                                  }
                                },
                                onFieldSubmitted: (String text) {
                                  try {
                                    final newSize = double.parse(text);

                                    if (newSize < 0 ||
                                        newSize >
                                            move.productUomQty!.toDouble()) {
                                      throw UnsupportedError(
                                        'El valor solo puede estar en el rango: 0.0 y ${move.productUomQty!.toDouble()}',
                                      );
                                    } else {
                                      move.reservedAvailivity =
                                          newSize.toDouble();
                                    }
                                    // setState(
                                    //     () => nroActual = newSize.toDouble());
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ContentDialog(
                                          content: Text(
                                            'El valor ingresado solo puede estar en el rango: 0.0 y ${move.productUomQty!.toDouble()}',
                                          ),
                                          actions: [
                                            FilledButton(
                                              child: const Text('Cerrar'),
                                              onPressed:
                                                  Navigator.of(context).pop,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  return text;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                      if (!limiteLineas) ...[
                        Row(
                          children: [
                            // Text('${move.productId}'),

                            // Flexible(

                            if (esPorSerie) ...[
                              TextLabel(
                                  width: 50,
                                  widthValue: 100,
                                  label: 'Producto ID',
                                  value: '$productId'),
                              ComboSearch<StockLot>(
                                constraints:
                                    const BoxConstraints(maxWidth: 190),
                                enabled: false,
                                dropKey: seriesDropKey,
                                title: 'Codigo de Barras',
                                selectedItem: loteActual,
                                asyncItems: (String busqueda) async {
                                  return getDataComboCodBar(
                                      ref,
                                      busqueda,
                                      productId,
                                      locationId,
                                      move.moveLineIdsData);
                                },
                                filterFn: (client, filter) {
                                  return (client.name!
                                      .toLowerCase()
                                      .contains(filter.toLowerCase()));
                                },
                                itemBuilder: itemBuilderListadoSeries,
                                itemAsString: (StockLot? data) {
                                  return '${data?.name}';
                                },
                                onChanged: (StockLot? data) {
                                  agregarAListadoDeMoveLine(
                                    context,
                                    ref,
                                    StockMoveLineList(
                                      id: 0,
                                      lotId: data!.id,
                                      lotName: '${data.name}',
                                      lotIdName: '${data.name}',
                                      productUomQty: 1.0,
                                      qtyDone: 0.0,
                                      productTracking: move.productTracking,
                                      locationId: move.locationId,
                                      locationDestId: move.locationDestId,
                                      productUomId: move.productUom,
                                    ),
                                  );
                                },
                                compareFn: (i, s) => i.isEqual(s),
                              ),
                              IconButton(
                                  icon: Icon(
                                    FluentIcons.circle_addition,
                                    color: theme.accentColor,
                                    size: 33.0,
                                  ),
                                  onPressed: limiteLineas
                                      ? null
                                      : () {
                                          seriesDropKey.currentState
                                              ?.openDropDownSearch();
                                        }),
                            ]
                          ],
                        )
                      ],
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            StockMoveLineListGrid(moveListRecords: move.moveLineIdsData),
          ],
        ));
  }
}
