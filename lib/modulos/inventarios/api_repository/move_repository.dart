import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_sources/stock_move_list_data_source.dart';
import '../models/picking_model.dart';
import 'dar_tipo_provider.dart';

void modificarMoveDesdeFormulario(
    BuildContext context, WidgetRef ref, PickingOrder? registroNuevo) {
  var mDespacho = darDespachoActualFormularioProviderNotifier(ref);
  mDespacho.state = registroNuevo!;
}

void seleccionarMoveDeLista(BuildContext context, WidgetRef ref,
    StockMoveListDataSource dataSource, int index) {
  if (index > 0) {
    final id = dataSource.recordData[index - 1]
        .getCells()
        .firstWhere((cel) => cel.columnName == 'id')
        .value as int;
    final mMovimientoListado = darMoveListProviderNotifier(ref);
    final mMovimiento = darMoveActualFormularioProviderNotifier(ref);
    mMovimiento.state = mMovimientoListado.getRegistro(id);
    // mMovimientoLineasListado.cargaRegistros(mMovimiento.state.moveLineIdsData);
  }
}
