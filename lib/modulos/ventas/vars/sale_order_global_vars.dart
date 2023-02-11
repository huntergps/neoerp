import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final DataGridController saleOrderListdataGridController = DataGridController();
final GlobalKey<SfDataGridState> saleOrderListGridKey =
    GlobalKey<SfDataGridState>();
final saleOrderListViewPageKey =
    GlobalKey(debugLabel: 'List SaleOrderList Page View Key');
final viewSaleOrderFormPageKey =
    GlobalKey(debugLabel: 'SaleOrder Form Page View Key');

final DataGridController dataGridControllerOrderLine = DataGridController();
final GlobalKey<SfDataGridState> gridKeyClientsLine =
    GlobalKey<SfDataGridState>();
