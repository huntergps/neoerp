//**************************************************************************************/
// DATASOURCE BASE DE SALEORDERLINE
//**************************************************************************************/

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/inventarios/models/stock_move_list_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isNumericType =
        column.columnName == 'productUomQty' || column.columnName == 'qtyDone';

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextBox(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }
}
//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LOS DATOS DENTRO DE LAS CELDAS DE SALEORDERLINE
//**************************************************************************************/

DataGridRowAdapter estiloCeldasStockMoveLineList(DataGridRow row) {
  // final moveLine = row.getCells();
  // if (moveLine.isNotEmpty) {
  //   final tracking =
  //       moveLine.firstWhere((e) => e.columnName == 'productTracking');
  // }
  // .firstWhere((e) => e.columnName == 'productTracking');
  // final tracking = moveLine.value;
  // print(tracking);
  final DataGridCell<dynamic> mProductTracking =
      row.getCells().firstWhere((cel) => cel.columnName == 'productTracking');
  final String tracking = mProductTracking.value;
  return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
    if (dataGridCell.columnName == 'id') {
      if (tracking != 'serial') {
        return Container();
      }
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
        // padding: EdgeInsets.only(bottom: 15.0),
        alignment: Alignment.center,
        child: const ButtonDeleteAllMoveLine(),
      ),
    ),
    GridColumn(
        columnName: 'name',
        allowEditing: true,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        minimumWidth: 220.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Detalle',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ))),
    // if (masterController.features.contains('precio_unitario')) ...[
    // GridColumn(
    //     columnName: 'productQty',
    //     allowEditing: true,
    //     maximumWidth: 70.0,
    //     minimumWidth: 60.0,
    //     label: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 6.0),
    //         alignment: Alignment.centerRight,
    //         child: Text(
    //           'Cantidad',
    //           style: TextStyle(fontSize: 12, color: Colors.white),
    //         ))),
    GridColumn(
        visible: move.state != 'done',
        columnName: 'productUomQty',
        allowEditing: true,
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
      allowEditing: true,
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
            // DataGridCell<double>(
            //     columnName: 'productQty', value: e.productQty!.toDouble()),
            DataGridCell<double>(
                columnName: 'productUomQty', value: e.productUomQty),
            DataGridCell<double>(columnName: 'qtyDone', value: e.qtyDone),
            DataGridCell<String>(
                columnName: 'productTracking', value: e.productTracking),
          ]))
      .toList();
}

class ButtonDeleteAllMoveLine extends ConsumerWidget {
  const ButtonDeleteAllMoveLine({
    super.key,
    // required this.id,
  });
  // final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);
    final iconColor = theme.activeColor;

    return IconButton(
        icon: Icon(
          FluentIcons.delete,
          color: iconColor,
          size: 20,
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
