import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/stock_move_line_list_model.dart';
import 'dar_tipo_provider.dart';

void quitarMoveLineDeLista(BuildContext context, WidgetRef ref, int id,
    {bool vaciarTodo = false}) {
  bool seguir = false;
  if (vaciarTodo == false) {
    seguir = id > 0;
  } else {
    seguir = true;
  }
  if (seguir) {
    final mMovimientoListado = darMoveListProviderNotifier(ref);
    final mMovimientoLineasListado = darMoveLineListProviderNotifier(ref);
    final mMovimientoActual = darMoveActualFormularioProviderNotifier(ref);

    if (vaciarTodo) {
      mMovimientoLineasListado.vaciar();
    } else {
      mMovimientoLineasListado.removeRegistro(id);
    }

    var movId = mMovimientoActual.state.id!.toInt();
    mMovimientoListado.ponerLineas(
        movId, mMovimientoLineasListado.getRegistros());
    mMovimientoActual.state = mMovimientoListado.getRegistro(movId);
  }
}

void agregarAListadoDeMoveLine(
    BuildContext context, WidgetRef ref, StockMoveLineList? newLinea) {
  bool seguir = true;
  if (newLinea == null) {
    seguir = false;
  }
  if (seguir) {
    final mMovimientoListado = darMoveListProviderNotifier(ref);
    final mMovimientoLineasListado = darMoveLineListProviderNotifier(ref);
    final mMovimientoActual = darMoveActualFormularioProviderNotifier(ref);

    mMovimientoLineasListado.newRegistro(newLinea!);
    var movId = mMovimientoActual.state.id!.toInt();
    mMovimientoListado.ponerLineas(
        movId, mMovimientoLineasListado.getRegistros());
    mMovimientoActual.state = mMovimientoListado.getRegistro(movId);
  }
}

void refrescarListadoDeMoveLine(BuildContext context, WidgetRef ref) {
  final mMovimientoLineasListado = darMoveLineListProviderNotifier(ref);
  final mMovimientoActual = darMoveActualFormularioProviderNotifier(ref);
  final mLineaMovimientoActual =
      darMoveLineActualFormularioProviderNotifier(ref);

  mMovimientoLineasListado
      .cargaRegistros(mMovimientoActual.state.moveLineIdsData);
  mLineaMovimientoActual.state = mMovimientoLineasListado.getRegistros().isEmpty
      ? StockMoveLineList()
      : mMovimientoLineasListado.getRegistros().first;
}

void modificarMoveLine(
    BuildContext context, WidgetRef ref, StockMoveLineList? lineaModificada) {
  bool seguir = true;
  if (lineaModificada == null) {
    seguir = false;
  }
  if (seguir) {
    final mMovimientoListado = darMoveListProviderNotifier(ref);
    final mMovimientoLineasListado = darMoveLineListProviderNotifier(ref);
    final mMovimientoActual = darMoveActualFormularioProviderNotifier(ref);
    final mLineaMovimientoActual =
        darMoveLineActualFormularioProviderNotifier(ref);

    mLineaMovimientoActual.state = lineaModificada!;
    mMovimientoLineasListado
        .getRegistros()
        .firstWhere((e) => e.id == lineaModificada.id);
    // first = lineaModificada;
    // mMovimientoLineasListado.updateRegistro(lineaModificada);
    var movId = mMovimientoActual.state.id!.toInt();
    mMovimientoListado.ponerLineas(
        movId, mMovimientoLineasListado.getRegistros());
    mMovimientoActual.state = mMovimientoListado.getRegistro(movId);
  }
}
