import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo/core/utils/device_info.dart';
import 'package:neo/modulos/ventas/models/sale_order_list.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../vars/sale_order_list_fields.dart';

class SaleOrderListDataSource extends DataGridSource {
  SaleOrderListDataSource({
    required List<SaleOrderList> records,
    required this.context,
  }) {
    recordData = saleOrderGetDataRows(records);
  }

  List<DataGridRow> recordData = [];
  final BuildContext context;

  void updateDataGridSource() {
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => recordData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return estiloCeldasSaleOrder(row);
  }

  DataGridRowAdapter estiloCeldasSaleOrder(DataGridRow row) {
    final isPhone = DeviceScreen.isPhone(context);
    final paddingHorizontal = isPhone ? 4.0 : 6.0;
    final fontSize = isPhone ? 10.0 : 12.0;

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      Color getColor() {
        if (dataGridCell.columnName == 'estadoDespachos') {
          if (dataGridCell.value == 'Despachado') {
            return Colors.green.lightest;
          }
          if (dataGridCell.value == 'Borrador') {
            return Colors.red.lightest;
          }
          if (dataGridCell.value == 'Para despachar') {
            return Colors.blue.lightest;
          }
          if (dataGridCell.value == 'Sin despachos') {
            return Colors.red.lightest;
          }
        }

        return Colors.transparent;
      }

      if (dataGridCell.columnName == 'amountTotal') {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          alignment: Alignment.centerRight,
          child: Text(
            dataGridCell.value == null
                ? ''
                : dataGridCell.value.toStringAsFixed(2),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize),
          ),
        );
      } else {
        return Container(
          color: getColor(),
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          alignment: Alignment.centerLeft,
          child: Text(
            dataGridCell.value == null ? '' : dataGridCell.value.toString(),
            style: TextStyle(fontSize: fontSize),
          ),
        );
      }
    }).toList());
  }
}

//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LAS CABECERAS DE LAS COLUMNAS DE CLIENT
//**************************************************************************************/

cabecerasTablaSaleOrder(BuildContext context) {
  final theme = FluentTheme.of(context);
  final isPhone = DeviceScreen.isPhone(context);

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
            child: Text(
              'ID',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'name',
        allowEditing: false,
        minimumWidth: isPhone ? 52 : 100.0,
        maximumWidth: isPhone ? 62 : 120.0,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Nombre',
              style: TextStyle(fontSize: 11, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'dateOrder',
        allowEditing: false,
        minimumWidth: isPhone ? 650 : 100.0,
        maximumWidth: isPhone ? 60 : 130.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Fecha',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'clienteName',
        allowEditing: false,
        minimumWidth: 94.0,
        maximumWidth: isPhone ? 150 : 770.0,
        columnWidthMode: ColumnWidthMode.fill,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cliente',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'amountTotal',
        allowSorting: false,
        allowEditing: false,
        minimumWidth: 45.0,
        maximumWidth: isPhone ? 60 : 100,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Total',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        visible: isPhone == false,
        columnName: 'paymentTermName',
        allowSorting: false,
        allowEditing: false,
        minimumWidth: 70.0,
        maximumWidth: 120,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Acuerdo Pago',
              style: TextStyle(fontSize: 10, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'state',
        allowSorting: false,
        allowEditing: false,
        minimumWidth: 60.0,
        columnWidthMode: ColumnWidthMode.fill,
        maximumWidth: isPhone ? 60 : 120,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Estado',
              style: TextStyle(fontSize: 10, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'estadoDespachos',
        allowSorting: false,
        allowEditing: false,
        minimumWidth: 60.0,
        columnWidthMode: ColumnWidthMode.fill,
        maximumWidth: isPhone ? 60 : 120,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Estado Despachos',
              style: TextStyle(fontSize: 10, color: theme.activeColor),
            ))),
  ];
  return mCab;
}

//**************************************************************************************/
// PONER LOS VALORES EN LAS CELDAS DE LA TABLA DE CLIENT
//**************************************************************************************/

List<DataGridRow> saleOrderGetDataRows(List<SaleOrderList> records) {
  return records
      .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'id', value: e.id),
            DataGridCell<String>(columnName: 'name', value: e.name),
            DataGridCell<String>(columnName: 'dateOrder', value: e.dateOrder),
            // DataGridCell<String>(columnName: 'clienteRuc', value: e.clienteRuc),
            DataGridCell<String>(
                columnName: 'clienteName', value: e.clienteName),
            DataGridCell<double>(
                columnName: 'amountTotal',
                value: double.parse(e.totalSri!.toStringAsFixed(2))),
            DataGridCell<String>(
                columnName: 'paymentTermName', value: e.paymentTermName),
            DataGridCell<String>(
                columnName: 'state', value: stateSaleOrderField[e.state]),
            DataGridCell<String>(
                columnName: 'estadoDespachos',
                value: e.estadoDespachoFiltro.toString()),
          ]))
      .toList();
}

// String getEstadoDespacho(String estados) {
//   if (estados.isEmpty) {
//     return 'Sin despachos';
//   }
//   final estadosList = estados.split(',').map((e) => e.trim()).toList();
//   if (estadosList.any((e) => ['draft', 'confirmed'].contains(e))) {
//     return 'Borrador';
//   } else if (estadosList.any((e) => ['confirmed', 'assigned'].contains(e))) {
//     return 'Para despachar';
//   } else if (estadosList.contains('done')) {
//     return 'Despachado';
//   } else if (estados.contains('cancel')) {
//     return 'Cancelado';
//   } else {
//     return 'Sin despachos';
//   }
// }
