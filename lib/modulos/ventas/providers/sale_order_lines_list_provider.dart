import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/ventas/models/sale_order_line_model.dart';

/// *************************************************************************/
/// PROVIDERS CON EL LISTADO DE REGISTROS de LINEAS
/// *************************************************************************/

class SaleOrderLineListNotifier extends StateNotifier<List<SaleOrderLine>> {
  SaleOrderLineListNotifier() : super([]);

  ///leer los registros desde un conjunto de datos y lo pone la lista
  void cargaRegistros(List<SaleOrderLine> data) {
    state = data;
  }

  ///Vaciar por completo lista
  void vaciar() {
    state = [];
  }

  SaleOrderLine getRegistro(int id) {
    return state.firstWhere((element) => element.id == id);
  }
}

final saleOrderLineListProvider =
    StateNotifierProvider<SaleOrderLineListNotifier, List<SaleOrderLine>>(
        (ref) {
  return SaleOrderLineListNotifier();
});
