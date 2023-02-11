import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:neo/core/utils/device_info.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/sale_order_line_model.dart';
import '../../data_sources/sale_order_lines_data_source.dart';
import '../../providers/sale_order_lines_list_provider.dart';
import '../../vars/sale_order_global_vars.dart';

class SaleOrderLinesGrid extends ConsumerStatefulWidget {
  const SaleOrderLinesGrid({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaleOrderLinesGridState();
}

class _SaleOrderLinesGridState extends ConsumerState<SaleOrderLinesGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final List<SaleOrderLine> saleOrderRecords =
        ref.watch(saleOrderLineListProvider);
    final SaleOrderLineDataSource saleOrdersdatasource =
        SaleOrderLineDataSource(context: context, records: saleOrderRecords);
    final isPhone = DeviceScreen.isPhone(context);

    return SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: theme.accentColor,
        ),
        child: SfDataGrid(
          key: gridKeyClientsLine,
          controller: dataGridControllerOrderLine,
          source: saleOrdersdatasource,
          columns: cabecerasTablaSaleOrderLine(context),
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          selectionMode: SelectionMode.single,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          headerRowHeight: 26,
          rowHeight: isPhone ? 48 : 40,
          // // allowSorting: true,
          // footerHeight: 1.0,
        ));
  }
}
