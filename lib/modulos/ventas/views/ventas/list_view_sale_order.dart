import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/core/utils/device_info.dart';
import 'package:neo/modulos/ventas/models/sale_order_list.dart';
import 'package:neo/modulos/ventas/api_repository/sale_order_repository.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data_sources/sale_order_datasource.dart';
import '../../providers/sale_order_list_provider.dart';
import '../../vars/sale_order_global_vars.dart';

class SaleOrderGrid extends ConsumerStatefulWidget {
  const SaleOrderGrid({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaleOrderGridState();
}

class _SaleOrderGridState extends ConsumerState<SaleOrderGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final List<SaleOrderList> saleOrderRecords =
        ref.watch(saleOrderListProvider);
    final SaleOrderListDataSource saleOrdersdatasource =
        SaleOrderListDataSource(context: context, records: saleOrderRecords);
    final isPhone = DeviceScreen.isPhone(context);

    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: theme.accentColor,
      ),
      child: SfDataGrid(
        key: saleOrderListGridKey,
        controller: saleOrderListdataGridController,
        source: saleOrdersdatasource,
        columns: cabecerasTablaSaleOrder(context),
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        selectionMode: SelectionMode.single,
        allowPullToRefresh: false,
        showCheckboxColumn: false,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        headerRowHeight: 32,
        rowHeight: isPhone ? 48 : 38,
        allowSorting: true,
        footerHeight: 1.0,
        rowsPerPage: ref.watch(tamanioRegistrosPaginaSaleOrderListProvider),
        onCellTap: (DataGridCellTapDetails details) {
          if (details.column.columnName == 'name') {
            saleOrderListdataGridController.selectedIndex =
                details.rowColumnIndex.rowIndex - 1;
            final index = details.rowColumnIndex.rowIndex;
            saleOrderListdataGridController.selectedIndex =
                details.rowColumnIndex.rowIndex - 1;
            seleccionarRegistrodeLista(
                context, ref, saleOrdersdatasource, index);
          }
        },
        onCellLongPress: (DataGridCellLongPressDetails details) {
          final index = details.rowColumnIndex.rowIndex;
          saleOrderListdataGridController.selectedIndex =
              details.rowColumnIndex.rowIndex - 1;
          seleccionarRegistrodeLista(context, ref, saleOrdersdatasource, index);
        },
        onCellDoubleTap: (DataGridCellDoubleTapDetails details) {
          // ref.read(vistaFormularioProvider.notifier).state = true;
          final index = details.rowColumnIndex.rowIndex;
          saleOrderListdataGridController.selectedIndex =
              details.rowColumnIndex.rowIndex - 1;
          seleccionarRegistrodeLista(context, ref, saleOrdersdatasource, index);
        },
      ),
    );
  }
}
