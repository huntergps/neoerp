import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../api_repository/dar_tipo_provider.dart';
import '../../api_repository/move_line_repository.dart';
import '../../api_repository/move_repository.dart';
import '../../data_sources/stock_move_list_data_source.dart';
import '../../models/stock_move_list_model.dart';
import '../../providers/stock_move_list_provider.dart';
import '../../vars/picking_order_global_vars.dart';

final CustomColumnSizer _customColumnSizer = CustomColumnSizer();

class StockMoveListGrid extends ConsumerStatefulWidget {
  const StockMoveListGrid({
    super.key,
    required this.moveListRecords,
  });

  final List<StockMoveList> moveListRecords;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockMoveListGridState();
}

class _StockMoveListGridState extends ConsumerState<StockMoveListGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    ref.listen<StockMoveList>(stockMoveActualDesdeVentasProvider,
        (StockMoveList? previousCount, StockMoveList newCount) {
      refrescarListadoDeMoveLine(context, ref);
    });

    final List<StockMoveList> moveLineListRecords = darMoveList(ref);
    final StockMoveListDataSource saleOrdersdatasource =
        StockMoveListDataSource(records: moveLineListRecords);

    return SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: theme.accentColor,
        ),
        child: SfDataGrid(
          key: gridKeyStockMoveLines,
          controller: dataGridControllerStockMoveLines,
          source: saleOrdersdatasource,
          // columnSizer: _customColumnSizer,
          onQueryRowHeight: (details) {
            return details.rowIndex < 1
                ? 26.0
                : details.getIntrinsicRowHeight(details.rowIndex) / 1.7;
          },
          // onQueryRowHeight: (details) {
          //   // return details.rowIndex == 1 ? 170.0 : 49.0;
          //   return details.rowIndex == 0
          //       ? 26.0
          //       : details.getIntrinsicRowHeight(details.rowIndex,
          //           excludedColumns: [
          //               'id',
          //               'productCode',
          //               'productTracking',
          //               'productUomQty',
          //               'reservedAvailivity'
          //             ]);
          // },
          columns: cabecerasTablaStockMoveList(ref),
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          selectionMode: SelectionMode.single,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          headerRowHeight: 26,
          rowHeight: 40,
          onCellTap: (DataGridCellTapDetails details) {
            dataGridControllerStockMoveLines.selectedIndex =
                details.rowColumnIndex.rowIndex - 1;
            final index = details.rowColumnIndex.rowIndex;
            seleccionarMoveDeLista(context, ref, saleOrdersdatasource, index);
          },
        ));
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellHeight(GridColumn column, DataGridRow row,
      Object? cellValue, TextStyle textStyle) {
    // if (column.columnName == 'Date of Birth') {
    //   cellValue = DateFormat.yMMMMd('en_US').format(cellValue as DateTime);
    // } else if (column.columnName == 'Salary') {
    //   cellValue =
    //       NumberFormat.simpleCurrency(decimalDigits: 0).format(cellValue);
    // }

    if (column.columnName == 'name') {
      if (cellValue.toString().contains('~^')) {
        textStyle = textStyle.copyWith(fontSize: 15.0);
      } else {
        textStyle = textStyle.copyWith(fontSize: 1.0);
      }
      //  else {
      //   textStyle = textStyle.copyWith(fontSize: 4.0);
      // }
    }
    return super.computeCellHeight(column, row, cellValue, textStyle);
  }
}
