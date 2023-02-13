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
          columns: cabecerasTablaStockMoveList(),
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
