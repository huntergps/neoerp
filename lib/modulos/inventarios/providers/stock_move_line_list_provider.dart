import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/common/models/lot_model.dart';

import '../models/stock_move_line_list_model.dart';

// /// *************************************************************************/
// /// PROVIDERS CON EL LISTADO DE REGISTROS de LINEAS
// /// *************************************************************************/

class StockMoveLineListNotifier extends StateNotifier<List<StockMoveLineList>> {
  StockMoveLineListNotifier() : super([]);

  void updateRegistro(StockMoveLineList? moveLineData) {
    state = [
      for (final move in state)
        if (move.id == moveLineData!.id) moveLineData else move,
    ];
  }

  void newRegistro(StockMoveLineList data) {
    state = [...state, data];
  }

  void cargaRegistros(List<StockMoveLineList>? data) {
    state = data!;
  }

  ///Vaciar por completo lista
  void vaciar() {
    state = [];
  }

  void removeRegistro(int id) {
    state = [
      for (final rec in state)
        if (rec.id != id) rec,
    ];
  }

  double sumarReservado() {
    double res = 0.0;
    for (final rec in state) {
      res = res + rec.productUomQty!.toDouble();
    }
    return res;
  }

  StockMoveLineList getRegistro(int id) {
    return state.firstWhere((element) => element.id == id);
  }

  List<StockMoveLineList> getRegistros() {
    return state;
  }
}

final stockMoveLineListDesdeVentaProvider =
    StateNotifierProvider<StockMoveLineListNotifier, List<StockMoveLineList>>(
        (ref) {
  return StockMoveLineListNotifier();
});

final stockMoveLineListDesdeDespachoProvider =
    StateNotifierProvider<StockMoveLineListNotifier, List<StockMoveLineList>>(
        (ref) {
  return StockMoveLineListNotifier();
});

final lineaMoveActualDesdeDespachosProvider = StateProvider<StockMoveLineList>(
  (ref) => StockMoveLineList(),
);

final lineaMoveActualDesdeVentasProvider = StateProvider<StockMoveLineList>(
  (ref) => StockMoveLineList(),
);

final loteActualDesdeDespachosProvider = StateProvider<StockLot>(
  (ref) => StockLot(id: 0, name: ''),
);

final loteActualDesdeVentasProvider = StateProvider<StockLot>(
  (ref) => StockLot(id: 0, name: ''),
);
