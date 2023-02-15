//**************************************************************************************/
// DATASOURCE BASE DE SALEORDERLINE
//**************************************************************************************/

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/entidades/api_repository/partner_repository.dart';
import 'package:neo/modulos/inventarios/models/stock_move_list_model.dart';
import 'package:neo/modulos/inventarios/vars/picking_order_global_vars.dart';
import 'package:neo/modulos/inventarios/widgets/combo_search.dart';
import 'package:neo/modulos/widgets/utils.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../common/models/lot_model.dart';
import '../api_repository/dar_tipo_provider.dart';
import '../api_repository/move_line_repository.dart';
import '../models/stock_move_line_list_model.dart';
import '../providers/picking_order_form_provider.dart';

class StockMoveLineListDataSource extends DataGridSource {
  StockMoveLineListDataSource({
    required records,
  }) {
    recordData = stockMoveListGetDataRows(records!);
  }
  List<StockMoveLineList>? records;

  List<DataGridRow> recordData = [];
  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => recordData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return estiloCeldasStockMoveLineList(row);
  }

  // @override
  // void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
  //     GridColumn column) {
  //   final dynamic oldValue = dataGridRow
  //           .getCells()
  //           .firstWhere((DataGridCell dataGridCell) =>
  //               dataGridCell.columnName == column.columnName)
  //           .value ??
  //       '';

  //   if (newCellValue == null || oldValue == newCellValue) {
  //     return;
  //   }

  //   final int dataRowIndex = rows.indexOf(dataGridRow);

  //   if (newCellValue == null || oldValue == newCellValue) {
  //     return;
  //   }
  //   if (column.columnName == 'name') {
  //     recordData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<String>(columnName: 'name', value: newCellValue);
  //     records![dataRowIndex].lotIdName = newCellValue.toString();
  //     records![dataRowIndex].lotName = newCellValue.toString();
  //   }
  //   print("***********>>>>");
  //   newCellValue = null;
  // }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    newCellValue = null;
    return Consumer(
      builder: (context, ref, child) {
        final StockMoveList move = darMoveActualFormulario(ref);
        final productId = move.productId!.toInt();
        final locationId = revisaVaciosInt(move.locationId);

        final StockLot loteActual =
            darLoteActualFormularioProviderNotifier(ref).state;
        final StockMoveLineList lineaActual =
            darMoveLineActualFormularioProviderNotifier(ref).state;

        final modoEdicion = ref.watch(pickingOrderEditarProvider);
        return ComboSearch<StockLot>(
          constraints: const BoxConstraints(maxWidth: 190),
          enabled: true,
          // dropKey: seriesDropKey,
          // title: 'Codigo de Barras',
          selectedItem: loteActual,
          asyncItems: (String busqueda) async {
            return getDataComboCodBar(
                ref, busqueda, productId, locationId, move.moveLineIdsData);
          },
          filterFn: (lote, filter) {
            return (lote.name!.toLowerCase().contains(filter.toLowerCase()));
          },
          itemBuilder: itemBuilderListadoSeries,
          itemAsString: (StockLot? data) {
            return '${data?.name}';
          },
          onChanged: (StockLot? data) {
            loteActual.id = data!.id;
            loteActual.name = data.name;
            // lineaActual.lotId = data!.id;
            // lineaActual.lotIdName = data.name;
            // lineaActual.lotName = data.name;
            final mMovimientoListado = darMoveListProviderNotifier(ref);

            final mMovimientoLineasListadoNotifier =
                darMoveLineListProviderNotifier(ref);
            mMovimientoLineasListadoNotifier.updateRegistro(
                lineaActual.copyWith(
                    lotId: data.id, lotIdName: data.name, lotName: data.name));
            var movId = move.id!.toInt();
            mMovimientoListado.ponerLineas(
                movId, mMovimientoLineasListadoNotifier.getRegistros());
            final mMovimientoActual =
                darMoveActualFormularioProviderNotifier(ref);
            mMovimientoActual.state = mMovimientoListado.getRegistro(movId);
            //mMovimientoActual.state = mMovimientoListado.getRegistro(movId);
            submitCell();
            // modificarMoveLine(
            //     context,
            //     ref,
            //     lineaActual.copyWith(
            //         lotId: data!.id, lotIdName: data.name, lotName: data.name));
            // agregarAListadoDeMoveLine(
            //   context,
            //   ref,
            //   StockMoveLineList(
            //     id: 0,
            //     lotId: data!.id,
            //     lotName: '${data.name}',
            //     lotIdName: '${data.name}',
            //     productUomQty: 1.0,
            //     qtyDone: 0.0,
            //     productTracking: move.productTracking,
            //     locationId: move.locationId,
            //     locationDestId: move.locationDestId,
            //     productUomId: move.productUom,
            //   ),
            // );
          },
          compareFn: (i, s) => i.isEqual(s),
        );
      },
    );
  }
}
//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LOS DATOS DENTRO DE LAS CELDAS DE SALEORDERLINE
//**************************************************************************************/

DataGridRowAdapter estiloCeldasStockMoveLineList(DataGridRow row) {
  final DataGridCell<dynamic> mProductTracking =
      row.getCells().firstWhere((cel) => cel.columnName == 'productTracking');
  final String tracking = mProductTracking.value;
  return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
    if (dataGridCell.columnName == 'id') {
      if (tracking != 'serial') {
        return Container();
      }
      // return Text(
      //   dataGridCell.value.toString(),
      //   style: TextStyle(fontSize: 10),
      // );
      return ButtonDeleteMoveLine(id: dataGridCell.value);
    }
    if (dataGridCell.columnName == 'productQty') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        alignment: Alignment.centerRight,
        child: Text(
          dataGridCell.value == null
              ? ''
              : dataGridCell.value.toStringAsFixed(2),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11),
        ),
      );
    }
    if (dataGridCell.columnName == 'productUomQty') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        alignment: Alignment.centerRight,
        child: Text(
          dataGridCell.value == null
              ? ''
              : dataGridCell.value.toStringAsFixed(2),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11),
        ),
      );
    }
    if (dataGridCell.columnName == 'salePriceUnit') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        alignment: Alignment.centerRight,
        child: Text(
          dataGridCell.value == null
              ? ''
              : dataGridCell.value.toStringAsFixed(3),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11),
        ),
      );
    }
    if (dataGridCell.columnName == 'priceUnitFinal') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        alignment: Alignment.centerRight,
        child: Text(
          dataGridCell.value == null
              ? ''
              : dataGridCell.value.toStringAsFixed(3),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        alignment: Alignment.centerLeft,
        child: Text(
          dataGridCell.value == null ? '' : dataGridCell.value.toString(),
          style: const TextStyle(fontSize: 11),
        ),
      );
    }
  }).toList());
}

//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LAS CABECERAS DE LAS COLUMNAS DE SALEORDERLINE
//**************************************************************************************/

cabecerasTablaStockMoveLineList(WidgetRef ref) {
  final StockMoveList move = darMoveActualFormularioProviderNotifier(ref).state;

  final modoEdicion = ref.watch(pickingOrderEditarProvider) == false;
  // if (modoEdicion == false) {

  final mCab = [
    GridColumn(
      visible: move.productTracking == 'serial' && modoEdicion,
      columnName: 'id',
      allowEditing: false,
      minimumWidth: 40.0,
      maximumWidth: 40.0,
      label: Container(
        alignment: Alignment.center,
        child: const ButtonDeleteAllMoveLine(),
      ),
    ),
    GridColumn(
        columnName: 'name',
        allowEditing: modoEdicion,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        minimumWidth: 220.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Detalle',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ))),
    GridColumn(
        visible: move.state != 'done',
        columnName: 'productUomQty',
        allowEditing: false,
        maximumWidth: 90.0,
        minimumWidth: 80.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'Reservado',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ))),
    GridColumn(
      visible: move.state == 'done',
      columnName: 'qtyDone',
      allowEditing: false,
      maximumWidth: 70.0,
      minimumWidth: 60.0,
      label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          alignment: Alignment.centerRight,
          child: const Text(
            'Hecho',
            style: TextStyle(fontSize: 12, color: Colors.white),
          )),
    ),
    GridColumn(
      visible: false,
      columnName: 'productTracking',
      maximumWidth: 70.0,
      minimumWidth: 60.0,
      label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          alignment: Alignment.centerRight,
          child: const Text(
            'Hecho',
            style: TextStyle(fontSize: 12, color: Colors.white),
          )),
    ),
    GridColumn(
      visible: true,
      columnName: 'lotId',
      maximumWidth: 70.0,
      minimumWidth: 60.0,
      label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          alignment: Alignment.centerRight,
          child: const Text(
            'lotId',
            style: TextStyle(fontSize: 12, color: Colors.white),
          )),
    )
  ];
  return mCab;
}

//**************************************************************************************/
// PONER LOS VALORES EN LAS CELDAS DE LA TABLA DE SALEORDERLINE
//**************************************************************************************/

List<DataGridRow> stockMoveListGetDataRows(List<StockMoveLineList> records) {
  return records
      .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'id', value: e.id),
            DataGridCell<String>(
                columnName: 'name',
                value: e.lotId!.toInt() == 0 ? e.lotName : e.lotIdName),
            DataGridCell<double>(
                columnName: 'productUomQty', value: e.productUomQty),
            DataGridCell<double>(columnName: 'qtyDone', value: e.qtyDone),
            DataGridCell<String>(
                columnName: 'productTracking', value: e.productTracking),
            DataGridCell<String>(columnName: 'lotId', value: '${e.lotId}'),
          ]))
      .toList();
}

class ButtonDeleteAllMoveLine extends ConsumerWidget {
  const ButtonDeleteAllMoveLine({
    super.key,
    // required this.id,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);
    final iconColor = theme.activeColor;

    return IconButton(
        icon: Icon(
          FluentIcons.delete,
          color: iconColor,
          size: 15,
        ),
        onPressed: () {
          quitarMoveLineDeLista(context, ref, 0, vaciarTodo: true);
        });
  }
}

class ButtonDeleteMoveLine extends ConsumerStatefulWidget {
  const ButtonDeleteMoveLine({
    super.key,
    required this.id,
  });
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ButtonDeleteMoveLineState();
}

class _ButtonDeleteMoveLineState extends ConsumerState<ButtonDeleteMoveLine> {
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final iconColor =
        theme.brightness.isLight ? Colors.red.dark : Colors.red.light;

    return IconButton(
        icon: Icon(
          FluentIcons.delete,
          color: iconColor,
        ),
        onPressed: () {
          quitarMoveLineDeLista(context, ref, widget.id);
        });
  }
}
