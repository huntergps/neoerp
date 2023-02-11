import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/inventarios/models/stock_move_line_list_model.dart';

import '../models/stock_move_list_model.dart';

// /// *************************************************************************/
// /// PROVIDERS CON EL LISTADO DE REGISTROS de LINEAS
// /// *************************************************************************/

class StockMoveListNotifier extends StateNotifier<List<StockMoveList>> {
  StockMoveListNotifier() : super([]);

  void ponerLineas(int id, List<StockMoveLineList>? moveLineIdsData) {
    double sumProductUomQty = 0.0;
    for (var element in moveLineIdsData!) {
      sumProductUomQty = sumProductUomQty + element.productUomQty!.toDouble();
      // print(sumProductUomQty);
    }
    state = [
      for (final move in state)
        if (move.id == id)
          move.copyWith(
              moveLineIdsData: moveLineIdsData,
              reservedAvailivity: sumProductUomQty)
        else
          move,
    ];
  }

  ///leer los registros desde un conjunto de datos y lo pone la lista
  void cargaRegistros(List<StockMoveList>? data) {
    state = data!;
  }

  ///Vaciar por completo lista
  void vaciar() {
    state = [];
  }

  StockMoveList getRegistro(int id) {
    return state.firstWhere((element) => element.id == id);
  }

  List<StockMoveList> getRegistros() {
    return state;
  }
}

final stockMoveListDesdeDespachosProvider =
    StateNotifierProvider<StockMoveListNotifier, List<StockMoveList>>((ref) {
  return StockMoveListNotifier();
});

final stockMoveListDesdeVentasProvider =
    StateNotifierProvider<StockMoveListNotifier, List<StockMoveList>>((ref) {
  return StockMoveListNotifier();
});

final stockMoveActualDesdeDespachosProvider = StateProvider<StockMoveList>(
  (ref) => StockMoveList(),
);

final stockMoveActualDesdeVentasProvider = StateProvider<StockMoveList>(
  (ref) => StockMoveList(),
);
