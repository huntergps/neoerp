import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/inventarios/models/picking_model_list.dart';

/// *************************************************************************/
/// PROVIDERS CON EL LISTADO DE REGISTROS DE DESPACHOS
/// *************************************************************************/
class PickingOrderListNotifier extends StateNotifier<List<PickingOrderList>> {
  PickingOrderListNotifier() : super([]);

  ///leer los registros desde un conjunto de datos y lo pone la lista
  void cargaRegistros(List<dynamic> data) {
    state = data.map((order) {
      return PickingOrderList.fromJson(order);
    }).toList();
  }

  ///Vaciar por completo lista
  void vaciar() {
    state = [];
  }

  PickingOrderList getRegistro(int id) {
    return state.firstWhere((element) => element.id == id);
  }

  List<PickingOrderList> getRegistros() {
    return state;
  }
}

final pickingOrderListProvider =
    StateNotifierProvider<PickingOrderListNotifier, List<PickingOrderList>>(
        (ref) {
  return PickingOrderListNotifier();
});

/// *************************************************************************/
/// PROVIDERS USADOS PARA LISTADO Y BUSQUEDA DE REGISTROS DE DESPACHOS
/// *************************************************************************/

final totalRegistrosConsultadosPickingOrderListProvider = StateProvider<int>(
  (ref) => 0,
);

final totalRegistrosCargadosPickingOrderListProvider = StateProvider<int>(
  (ref) => 0,
);

final paginaActualPickingOrderListProvider = StateProvider<int>(
  (ref) => 0,
);

final tamanioRegistrosPaginaPickingOrderListProvider = StateProvider<int>(
  (ref) => 80,
);

final busquedaPickingOrderListProvider = StateProvider<String>(
  (ref) => '',
);
