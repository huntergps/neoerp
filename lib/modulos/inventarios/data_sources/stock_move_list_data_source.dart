//**************************************************************************************/
// DATASOURCE BASE DE SALEORDERLINE
//**************************************************************************************/

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../api_repository/dar_tipo_provider.dart';
import '../models/stock_move_list_model.dart';

class StockMoveListDataSource extends DataGridSource {
  StockMoveListDataSource({
    required List<StockMoveList> records,
  }) {
    recordData = stockMoveListGetDataRows(records);
  }
  List<DataGridRow> recordData = [];

  @override
  List<DataGridRow> get rows => recordData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return estiloCeldasStockMoveList(row);
  }

//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LOS DATOS DENTRO DE LAS CELDAS DE SALEORDERLINE
//**************************************************************************************/

  DataGridRowAdapter estiloCeldasStockMoveList(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'reservedAvailivity') {
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
      if (dataGridCell.columnName == 'qtyDone') {
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
      if (dataGridCell.columnName == 'qtyDisponible') {
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

  void updateDataGridSource() {
    notifyListeners();
  }
}

//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LAS CABECERAS DE LAS COLUMNAS DE SALEORDERLINE
//**************************************************************************************/

cabecerasTablaStockMoveList(WidgetRef ref) {
  final StockMoveList move = darMoveActualFormularioProviderNotifier(ref).state;

  final mCab = [
    GridColumn(
        visible: false,
        columnName: 'id',
        allowEditing: false,
        minimumWidth: 100.0,
        maximumWidth: 130.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'ID',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ))),
    GridColumn(
        columnName: 'productCode',
        // allowEditing: true,
        maximumWidth: 90.0,
        minimumWidth: 65.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Codigo',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'name',
        allowEditing: false,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        minimumWidth: 200.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Detalle',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'productUomQty',
        allowEditing: false,
        maximumWidth: 60.0,
        minimumWidth: 40.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'Cantidad',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        visible: move.state != 'done',
        columnName: 'reservedAvailivity',
        allowEditing: true,
        maximumWidth: 60.0,
        minimumWidth: 40.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Reservado',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        visible: move.state == 'done',
        columnName: 'qtyDone',
        allowEditing: true,
        maximumWidth: 60.0,
        minimumWidth: 40.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Hecho',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        // visible: move.state != 'done',
        columnName: 'qtyDisponible',
        allowEditing: true,
        maximumWidth: 60.0,
        minimumWidth: 40.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Existencia',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'productUomName',
        allowEditing: true,
        maximumWidth: 50.0,
        minimumWidth: 45.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Unidad',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'salePriceUnit',
        allowEditing: false,
        maximumWidth: 70.0,
        minimumWidth: 60.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'Costo',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'priceUnitFinal',
        allowEditing: false,
        maximumWidth: 70.0,
        minimumWidth: 60.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'Precio',
              style: TextStyle(fontSize: 12, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))),
  ];
  return mCab;
}

//**************************************************************************************/
// PONER LOS VALORES EN LAS CELDAS DE LA TABLA DE SALEORDERLINE
//**************************************************************************************/

List<DataGridRow> stockMoveListGetDataRows(List<StockMoveList> records) {
  return records
      .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'id', value: e.id),
            DataGridCell<String>(
                columnName: 'productCode', value: e.productCode),
            DataGridCell<String>(columnName: 'name', value: e.productIdName),
            DataGridCell<double>(
                columnName: 'productUomQty',
                value: e.productUomQty!.toDouble()),
            DataGridCell<double>(
                columnName: 'reservedAvailivity',
                value: e.reservedAvailivity!.toDouble()),
            DataGridCell<double>(
                columnName: 'qtyDone', value: e.quantityDone!.toDouble()),
            DataGridCell<double>(
                columnName: 'qtyDisponible',
                value: e.qtyDisponible!.toDouble()),
            DataGridCell<String>(
                columnName: 'productUomName', value: e.productUomName),
            DataGridCell<double>(
                columnName: 'priceUnitFinal', value: e.priceUnitFinal),
            DataGridCell<double>(
                columnName: 'salePriceUnit', value: e.salePriceUnit),
          ]))
      .toList();
}
