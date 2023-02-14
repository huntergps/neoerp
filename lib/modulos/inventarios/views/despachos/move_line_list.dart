import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../api_repository/dar_tipo_provider.dart';
import '../../data_sources/stock_move_line_list_data_source.dart';
import '../../models/stock_move_line_list_model.dart';
import '../../vars/picking_order_global_vars.dart';

class StockMoveLineListGrid extends ConsumerStatefulWidget {
  const StockMoveLineListGrid({
    super.key,
    required this.moveListRecords,
  });

  final List<StockMoveLineList>? moveListRecords;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockMoveLineListGridState();
}

class _StockMoveLineListGridState extends ConsumerState<StockMoveLineListGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final List<StockMoveLineList> moveLineListRecords =
        darMoveLineListProviderNotifier(ref).getRegistros();

    final StockMoveLineListDataSource moveLineListdatasource =
        StockMoveLineListDataSource(records: moveLineListRecords);

    return SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: theme.accentColor,
        ),
        child: SfDataGrid(
          key: gridKeyStockMoveLineList,
          controller: dataGridControllerStockMoveLineList,
          source: moveLineListdatasource,
          columns: cabecerasTablaStockMoveLineList(ref),
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          selectionMode: SelectionMode.single,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          headerRowHeight: 26,
          rowHeight: 30,
          // allowEditing: true,
          editingGestureType: EditingGestureType.tap,
        ));
  }
}