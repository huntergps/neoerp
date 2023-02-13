import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers_general.dart';
import '../data_sources/stock_move_list_data_source.dart';
import '../models/picking_model.dart';
import '../providers/stock_move_list_provider.dart';
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
    final mMovimiento = //darMoveActualFormularioProviderNotifier(ref);
        (ref.watch(tipoPantalla) == "sale_despacho_form")
            ? ref.read(stockMoveActualDesdeVentasProvider.notifier)
            : ref.read(stockMoveActualDesdeDespachosProvider.notifier);
    mMovimiento.state = mMovimientoListado.getRegistro(id);
    print(mMovimiento.state.id);
  }
}
