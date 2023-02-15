//**************************************************************************************/
// DATASOURCE BASE DE SALEORDERLINE
//**************************************************************************************/

import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../core/utils/device_info.dart';
import '../models/sale_order_line_model.dart';

class SaleOrderLineDataSource extends DataGridSource {
  SaleOrderLineDataSource({
    required List<SaleOrderLine> records,
    required this.context,
  }) {
    recordData = saleOrderLineGetDataRows(context, records);
  }
  List<DataGridRow> recordData = [];
  final BuildContext context;
  @override
  List<DataGridRow> get rows => recordData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return estiloCeldasSaleOrderLine(row);
  }

//**************************************************************************************/
// COMO SE QUIERE VISUALIZAR LOS DATOS DENTRO DE LAS CELDAS DE SALEORDERLINE
//**************************************************************************************/

  DataGridRowAdapter estiloCeldasSaleOrderLine(DataGridRow row) {
    final isPhone = DeviceScreen.isPhone(context);
    final paddingHorizontal = isPhone ? 2.0 : 6.0;
    final fontSize = isPhone ? 10.0 : 12.0;

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'productUomQty') {
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
      }

      if (dataGridCell.columnName == 'priceUnit') {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          alignment: Alignment.centerRight,
          child: Text(
            dataGridCell.value == null
                ? ''
                : dataGridCell.value.toStringAsFixed(3),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize),
          ),
        );
      }

      if (dataGridCell.columnName == 'discount') {
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
      }

      if (dataGridCell.columnName == 'priceSubtotal') {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          alignment: Alignment.centerRight,
          child: Text(
            dataGridCell.value == null
                ? ''
                : dataGridCell.value.toStringAsFixed(3),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize),
          ),
        );
      }

      if (dataGridCell.columnName == 'montoiva') {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          alignment: Alignment.centerRight,
          child: Text(
            dataGridCell.value == null
                ? ''
                : dataGridCell.value.toStringAsFixed(3),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize),
          ),
        );
      }

      if (dataGridCell.columnName == 'priceTotal') {
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
      }

      if (dataGridCell.columnName == 'purchase_price') {
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
      }

      if (dataGridCell.columnName == 'margin_percent') {
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
// COMO SE QUIERE VISUALIZAR LAS CABECERAS DE LAS COLUMNAS DE SALEORDERLINE
//**************************************************************************************/

cabecerasTablaSaleOrderLine(BuildContext context) {
  final theme = FluentTheme.of(context);
  final isPhone = DeviceScreen.isPhone(context);
  final paddingHorizontal = isPhone ? 3.0 : 6.0;
  final fontSize = isPhone ? 10.0 : 12.0;

  final mCab = [
    GridColumn(
        columnName: 'productCode',
        visible: isPhone == false,
        minimumWidth: isPhone ? 40 : 100.0,
        maximumWidth: isPhone ? 52 : 140.0,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerLeft,
            child: Text(
              'Codigo',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'name',
        allowEditing: false,
        minimumWidth: isPhone ? 60 : 100.0,
        maximumWidth: isPhone ? 162 : 520.0,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerLeft,
            child: Text(
              'Detalle',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),
    // if (masterController.features.contains('precio_unitario')) ...[
    GridColumn(
        columnName: 'productUomQty',
        minimumWidth: isPhone ? 25 : 60.0,
        maximumWidth: isPhone ? 35 : 80.0,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerRight,
            child: Text(
              isPhone ? 'Cant' : 'Cantidad',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),

    GridColumn(
        columnName: 'priceUnit',
        minimumWidth: isPhone ? 30 : 60.0,
        maximumWidth: isPhone ? 48 : 80.0,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerRight,
            child: Text(
              'Precio',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),

    GridColumn(
        columnName: 'discount',
        allowEditing: true,
        minimumWidth: isPhone ? 30 : 60.0,
        maximumWidth: isPhone ? 38 : 80.0,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerRight,
            child: Text(
              isPhone ? '%Dto' : '% Dscto',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        visible: isPhone == false,
        columnName: 'montodiscount',
        minimumWidth: isPhone ? 30 : 60.0,
        maximumWidth: isPhone ? 55 : 80.0,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerRight,
            child: Text(
              'Monto Dscto',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'priceSubtotal',
        minimumWidth: isPhone ? 30 : 60.0,
        maximumWidth: isPhone ? 52 : 80.0,
        // columnWidthMode: ColumnWidthMode.fill,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerRight,
            child: Text(
              'SubTotal',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        visible: isPhone == false,
        columnName: 'montoiva',
        minimumWidth: isPhone ? 30 : 60.0,
        maximumWidth: isPhone ? 55 : 80.0,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerRight,
            child: Text(
              'IVA',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        visible: isPhone == false,
        columnName: 'priceTotal',
        minimumWidth: isPhone ? 30 : 60.0,
        maximumWidth: isPhone ? 55 : 80.0,
        label: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            alignment: Alignment.centerRight,
            child: Text(
              'Total',
              style: TextStyle(fontSize: fontSize, color: theme.activeColor),
              overflow: TextOverflow.ellipsis,
            ))),
  ];
  return mCab;
}

//**************************************************************************************/
// PONER LOS VALORES EN LAS CELDAS DE LA TABLA DE SALEORDERLINE
//**************************************************************************************/

List<DataGridRow> saleOrderLineGetDataRows(
    BuildContext context, List<SaleOrderLine> records) {
  final isPhone = DeviceScreen.isPhone(context);

  return records
      .map<DataGridRow>((e) => DataGridRow(cells: [
            DataGridCell<String>(
                columnName: 'productCode', value: e.productCode),
            if (isPhone) ...[
              DataGridCell<String>(
                  columnName: 'name', value: '[ ${e.productCode} ] ${e.name}'),
            ] else ...[
              DataGridCell<String>(columnName: 'name', value: e.name),
            ],
            DataGridCell<double>(
                columnName: 'productUomQty', value: e.productUomQty),
            DataGridCell<double>(columnName: 'priceUnit', value: e.priceUnit),
            DataGridCell<double>(columnName: 'discount', value: e.discount),
            DataGridCell<double>(
                columnName: 'montodiscount', value: e.montodiscount),
            DataGridCell<double>(
                columnName: 'priceSubtotal', value: e.priceSubtotal),
            DataGridCell<double>(columnName: 'montoiva', value: e.montoiva),
            DataGridCell<double>(columnName: 'priceTotal', value: e.priceTotal),
          ]))
      .toList();
}
