import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/partner_model.dart';

/// *************************************************************************/
/// PROVIDERS CON EL LISTADO DE REGISTROS DE ORDENES DE VENTAS
/// *************************************************************************/

class PartnerListNotifier extends StateNotifier<List<PartnerList>> {
  PartnerListNotifier() : super([]);

  ///leer los registros desde un conjunto de datos y lo pone la lista
  void cargaRegistros(List<dynamic> data) {
    state = data.map((order) => PartnerList.fromJson(order)).toList();
  }

  ///Vaciar por completo lista
  void vaciar() {
    state = [];
  }

  PartnerList getRegistro(int id) {
    return state.firstWhere((element) => element.id == id);
  }
}

final partnerListProvider =
    StateNotifierProvider<PartnerListNotifier, List<PartnerList>>((ref) {
  return PartnerListNotifier();
});

/// *************************************************************************/
/// PROVIDERS USADOS PARA LISTADO Y BUSQUEDA DE REGISTROS DE ORDENES DE VENTAS
/// *************************************************************************/

final totalRegistrosConsultadosPartnerListProvider = StateProvider<int>(
  (ref) => 0,
);

final totalRegistrosCargadosPartnerListProvider = StateProvider<int>(
  (ref) => 0,
);

final paginaActualPartnerListProvider = StateProvider<int>(
  (ref) => 0,
);

final tamanioRegistrosPaginaPartnerListProvider = StateProvider<int>(
  (ref) => 80,
);

final busquedaPartnerListProvider = StateProvider<String>(
  (ref) => '',
);
