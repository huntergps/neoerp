import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo/modulos/inventarios/models/picking_model_list.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../vars/picking_list_fields.dart';

class PickingOrderListDataSource extends DataGridSource {
  PickingOrderListDataSource({
    required List<PickingOrderList> records,
  }) {
    recordData = pickingOrderGetDataRows(records);
  }

  List<DataGridRow> recordData = [];

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
    // final DataGridCell<dynamic> mid =
    //     row.getCells().firstWhere((cel) => cel.columnName == 'id');
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        alignment: Alignment.centerLeft,
        child: Text(
          dataGridCell.value == null ? '' : dataGridCell.value.toString(),
          style: const TextStyle(fontSize: 11),
        ),
      );
    }).toList());
  }
}

//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LAS CABECERAS DE LAS COLUMNAS DE CLIENT
//**************************************************************************************/

cabecerasTablaPickingOrder(BuildContext context) {
  final theme = FluentTheme.of(context);

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
        minimumWidth: 80.0,
        maximumWidth: 110.0,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Nombre',
              style: TextStyle(fontSize: 11, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'origin',
        allowSorting: false,
        allowEditing: false,
        // minimumWidth: 60.0,
        maximumWidth: 130,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Origen',
              style: TextStyle(fontSize: 10, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'locationName',
        allowSorting: false,
        allowEditing: false,
        minimumWidth: 90.0,
        maximumWidth: 100,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Origen',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'locationDestName',
        allowSorting: false,
        allowEditing: false,
        minimumWidth: 90.0,
        maximumWidth: 100,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Destino',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'clienteName',
        allowEditing: false,
        minimumWidth: 80.0,
        maximumWidth: 250.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Entidad',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'userName',
        allowEditing: false,
        minimumWidth: 60.0,
        maximumWidth: 100.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Usuario',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'scheduledDate',
        allowEditing: false,
        minimumWidth: 80.0,
        maximumWidth: 90.0,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Fecha prevista',
              style: TextStyle(fontSize: 12, color: theme.activeColor),
            ))),

    // GridColumn(
    //     columnName: 'priority',
    //     allowSorting: false,
    //     allowEditing: false,
    //     // minimumWidth: 60.0,
    //     // maximumWidth: 100,
    //     label: Container(
    //         padding: EdgeInsets.symmetric(horizontal: 6.0),
    //         alignment: Alignment.centerLeft,
    //         child: Text(
    //           'Prioridad',
    //           style: TextStyle(fontSize: 10, color: theme.activeColor),
    //         ))),
    GridColumn(
        columnName: 'pickingTypeName',
        allowSorting: false,
        allowEditing: false,
        // minimumWidth: 60.0,
        maximumWidth: 120,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Operacion',
              style: TextStyle(fontSize: 10, color: theme.activeColor),
            ))),
    GridColumn(
        columnName: 'state',
        allowSorting: false,
        allowEditing: false,
        // minimumWidth: 60.0,
        maximumWidth: 80,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Estado',
              style: TextStyle(fontSize: 10, color: theme.activeColor),
            ))),
  ];
  return mCab;
}

//**************************************************************************************/
// PONER LOS VALORES EN LAS CELDAS DE LA TABLA DE CLIENT
//**************************************************************************************/

List<DataGridRow> pickingOrderGetDataRows(List<PickingOrderList> records) {
  return records
      .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: 'id', value: e.id),
            DataGridCell<String>(columnName: 'name', value: e.name),
            DataGridCell<String>(columnName: 'origin', value: e.origin),

            DataGridCell<String>(
                columnName: 'locationName', value: e.locationName),
            DataGridCell<String>(
                columnName: 'locationDestName', value: e.locationDestName),
            DataGridCell<String>(
                columnName: 'clienteName', value: e.clienteName),
            DataGridCell<String>(
                columnName: 'userName',
                value: e.userName!.split('.')[0].toUpperCase()),
            DataGridCell<String>(
                columnName: 'scheduledDate', value: e.scheduledDate),
            // DataGridCell<String>(columnName: 'priority', value: e.priority),
            DataGridCell<String>(
                columnName: 'pickingTypeName', value: e.pickingTypeName),
            DataGridCell<String>(
                columnName: 'state', value: statePickingOrderField[e.state]),
          ]))
      .toList();
}
