import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/providers/providers_general.dart';

import '../../common/models/lot_model.dart';
import '../models/picking_model.dart';
import '../models/stock_move_line_list_model.dart';
import '../models/stock_move_list_model.dart';
import '../providers/picking_order_form_provider.dart';
import '../providers/stock_move_line_list_provider.dart';
import '../providers/stock_move_list_provider.dart';

StockMoveListNotifier darMoveListProviderNotifier(WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(stockMoveListDesdeVentasProvider.notifier)
      : ref.watch(stockMoveListDesdeDespachosProvider.notifier);
}

List<StockMoveList> darMoveList(WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(stockMoveListDesdeVentasProvider)
      : ref.watch(stockMoveListDesdeDespachosProvider);
}

StateController<StockMoveList> darMoveActualFormularioProviderNotifier(
    WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(stockMoveActualDesdeVentasProvider.notifier)
      : ref.watch(stockMoveActualDesdeDespachosProvider.notifier);
}

StockMoveList darMoveActualFormulario(WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(stockMoveActualDesdeVentasProvider)
      : ref.watch(stockMoveActualDesdeDespachosProvider);
}

StockMoveLineListNotifier darMoveLineListProviderNotifier(WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(stockMoveLineListDesdeVentaProvider.notifier)
      : ref.watch(stockMoveLineListDesdeDespachoProvider.notifier);
}

StateController<StockMoveLineList> darMoveLineActualFormularioProviderNotifier(
    WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(lineaMoveActualDesdeVentasProvider.notifier)
      : ref.watch(lineaMoveActualDesdeDespachosProvider.notifier);
}

StateController<PickingOrder> darDespachoActualFormularioProviderNotifier(
    WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(pickingOrderFormDesdeVentasProvider.notifier)
      : ref.watch(pickingOrderFormProvider.notifier);
}

StateController<StockLot> darLoteActualFormularioProviderNotifier(
    WidgetRef ref) {
  return (ref.watch(tipoPantalla) == "sale_despacho_form")
      ? ref.watch(loteActualDesdeVentasProvider.notifier)
      : ref.watch(loteActualDesdeDespachosProvider.notifier);
}
