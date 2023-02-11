import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../common/models/lot_model.dart';

final DataGridController pickingOrderListdataGridController =
    DataGridController();
final GlobalKey<SfDataGridState> pickingOrderListGridKey =
    GlobalKey<SfDataGridState>();
final pickingOrderListViewPageKey =
    GlobalKey(debugLabel: 'List SaleOrderList Page View Key');
final viewPickingOrderFormPageKey =
    GlobalKey(debugLabel: 'SaleOrder Form Page View Key');

final DataGridController dataGridControllerStockMoveLines =
    DataGridController();
final GlobalKey<SfDataGridState> gridKeyStockMoveLines =
    GlobalKey<SfDataGridState>();

final DataGridController dataGridControllerStockMoveLineList =
    DataGridController();
final GlobalKey<SfDataGridState> gridKeyStockMoveLineList =
    GlobalKey<SfDataGridState>();

final seriesDropKey = GlobalKey<DropdownSearchState<StockLot>>();
