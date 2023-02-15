import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/inventarios/api_repository/picking_order_repository.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data_sources/picking_order_datasource.dart';
import '../../models/picking_model_list.dart';
import '../../providers/picking_order_list_provider.dart';
import '../../vars/picking_order_global_vars.dart';

class PickingOrderGrid extends ConsumerStatefulWidget {
  const PickingOrderGrid({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PickingOrderGridState();
}

class _PickingOrderGridState extends ConsumerState<PickingOrderGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final List<PickingOrderList> pickingOrderRecords =
        ref.watch(pickingOrderListProvider);
    final PickingOrderListDataSource pickingOrdersdatasource =
        PickingOrderListDataSource(records: pickingOrderRecords);

    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: theme.accentColor,
      ),
      child: SfDataGrid(
        key: pickingOrderListGridKey,
        controller: pickingOrderListdataGridController,
        source: pickingOrdersdatasource,
        columns: cabecerasTablaPickingOrder(context),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        selectionMode: SelectionMode.single,
        allowPullToRefresh: false,
        showCheckboxColumn: false,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        headerRowHeight: 32,
        rowHeight: 38,
        allowSorting: true,
        footerHeight: 1.0,
        rowsPerPage: ref.watch(tamanioRegistrosPaginaPickingOrderListProvider),
        onCellTap: (DataGridCellTapDetails details) {
          if (details.column.columnName == 'name') {
            pickingOrderListdataGridController.selectedIndex =
                details.rowColumnIndex.rowIndex - 1;
            final index = details.rowColumnIndex.rowIndex;
            pickingOrderListdataGridController.selectedIndex =
                details.rowColumnIndex.rowIndex - 1;
            seleccionarRegistrodeLista(
                context, ref, pickingOrdersdatasource, index);
          }
        },
        onCellLongPress: (DataGridCellLongPressDetails details) {
          final index = details.rowColumnIndex.rowIndex;
          pickingOrderListdataGridController.selectedIndex =
              details.rowColumnIndex.rowIndex - 1;
          seleccionarRegistrodeLista(
              context, ref, pickingOrdersdatasource, index);
        },
        onCellDoubleTap: (DataGridCellDoubleTapDetails details) {
          final index = details.rowColumnIndex.rowIndex;
          pickingOrderListdataGridController.selectedIndex =
              details.rowColumnIndex.rowIndex - 1;
          seleccionarRegistrodeLista(
              context, ref, pickingOrdersdatasource, index);
        },
      ),
    );
  }
}
