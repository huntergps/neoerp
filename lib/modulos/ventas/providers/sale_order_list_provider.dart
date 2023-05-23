import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sale_order_list.dart';
import '../vars/sale_order_filters.dart';

/// *************************************************************************/
/// PROVIDERS CON EL LISTADO DE REGISTROS DE ORDENES DE VENTAS
/// *************************************************************************/

class SaleOrderListNotifier extends StateNotifier<List<SaleOrderList>> {
  SaleOrderListNotifier() : super([]);

  ///leer los registros desde un conjunto de datos y lo pone la lista
  void cargaRegistros(List<dynamic> data) {
    state = data.map((order) => SaleOrderList.fromJson(order)).toList();
  }

  ///Vaciar por completo lista
  void vaciar() {
    state = [];
  }

  SaleOrderList getRegistro(int id) {
    return state.firstWhere((element) => element.id == id);
  }
}

final saleOrderListProvider =
    StateNotifierProvider<SaleOrderListNotifier, List<SaleOrderList>>((ref) {
  return SaleOrderListNotifier();
});

/// *************************************************************************/
/// PROVIDERS USADOS PARA LISTADO Y BUSQUEDA DE REGISTROS DE ORDENES DE VENTAS
/// *************************************************************************/

final totalRegistrosConsultadosSaleOrderListProvider = StateProvider<int>(
  (ref) => 0,
);

final totalRegistrosCargadosSaleOrderListProvider = StateProvider<int>(
  (ref) => 0,
);

final paginaActualSaleOrderListProvider = StateProvider<int>(
  (ref) => 0,
);

final tamanioRegistrosPaginaSaleOrderListProvider = StateProvider<int>(
  (ref) => 80,
);

final busquedaSaleOrderListProvider = StateProvider<String>(
  (ref) => '',
);

final busquedaFiltroSaleOrderListProvider = StateProvider<String>(
  (ref) => saleOrderEstateFilterItemsInitialValue,
);

final busquedaFiltroDespachosSaleOrderListProvider = StateProvider<String>(
  (ref) => saleOrderDespachoEstateFilterItemsInitialValue,
);
