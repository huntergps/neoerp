import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/widgets/error_dialog.dart';

import '../../../providers/dio_provider.dart';
import '../data_sources/picking_order_datasource.dart';
import '../models/picking_model.dart';
import '../providers/picking_order_list_provider.dart';
import '../providers/picking_order_form_provider.dart';
import 'dar_tipo_provider.dart';

void seleccionarRegistrodeLista(BuildContext context, WidgetRef ref,
    PickingOrderListDataSource dataSource, int index) {
  if (index > 0) {
    final id = dataSource.recordData[index - 1]
        .getCells()
        .firstWhere((cel) => cel.columnName == 'id')
        .value as int;

    getRemoteRecordDespacho(context, ref, id);
  }
}

void despachoRefreshEstadoFacturas(
  BuildContext context,
  WidgetRef ref,
  int id,
  String accion,
) async {
  final dioClient = ref.watch(dioHttpProvider);
  final String getTokenUrl = '/api/stock_picking/$id';
  final url = dioClient.options.baseUrl + getTokenUrl;
  // final filtermio = "[('id','=','$id')]";
  final dbConfig = {"action": accion};
  var errorMsn = "";
  try {
    final result = await dioClient.post(url, data: jsonEncode(dbConfig));
    // .get(url, queryParameters: {'detail': true, 'filters': filtermio});

    if (result.statusCode == 200) {
      // final mresults = result.data;
      // final data = mresults['results'].first;

      getRemoteRecordDespacho(context, ref, id);
    }
  } on DioError catch (e) {
    if (e.response != null) {
      final mdata = e.response!.data;
      errorMsn = " ${mdata['error_descrip']}";
      showErrorDialog(context, 'Error', errorMsn);
    } else {
      errorMsn = " ${e.message}";
      showErrorDialog(context, 'Error', errorMsn);
    }
    ref.read(dioErrorMsnProvider.notifier).state = errorMsn;

    ref.read(dioLoadingProvider.notifier).state = false;
  }
}

void setRemoteRecordDespacho(
    BuildContext context, WidgetRef ref, int id) async {
  final dioClient = ref.watch(dioHttpProvider);
  final String getTokenUrl = '/api/stock_picking_save/$id';
  final url = dioClient.options.baseUrl + getTokenUrl;
  var errorMsn = "";
  try {
    var mDespacho = darDespachoActualFormularioProviderNotifier(ref);
    final mMovimientoListado = darMoveListProviderNotifier(ref);
    final newMoveData = [];
    for (var movimiento in mMovimientoListado.getRegistros()) {
      final lineas = movimiento.moveLineIdsData;
      final newMoveLinesData = [];
      for (var linea in lineas!) {
        newMoveLinesData.add({
          'id': linea.id,
          'product_id': movimiento.productId,
          // 'company_id': 1,
          'product_qty': linea.productQty,
          'product_uom_qty': linea.productUomQty,
          'qty_done': linea.qtyDone,
          'lot_id': linea.lotId,
          'product_uom_id': linea.productUomId,
          'location_id': linea.locationId,
          'location_dest_id': linea.locationDestId,
          'tracking': linea.productTracking,
          // 'company_id': 1,
        });
      }
      newMoveData.add({
        'id': movimiento.id,
        'product_id': movimiento.productId,
        'move_lines': newMoveLinesData,
        // 'company_id': 1,
        'product_qty': movimiento.productQty,
        'product_uom': movimiento.productUom,
        'location_id': movimiento.locationId,
        'location_dest_id': movimiento.locationDestId,
      });
      // }
    }
    final newData = {
      'id': mDespacho.state.id,
      'user_id': mDespacho.state.userId,
      'state_type': mDespacho.state.stateType,
      'partner_venta_id': mDespacho.state.partnerVentaId,
      'move_line_ids': newMoveData
    };
    final result = await dioClient.post(url, data: json.encode(newData));
    if (result.statusCode == 200) {
      // final mresults = result.data;
      // final data = mresults['results'].first;
      // putDespachoInProviders(ref, data);
      ref.read(pickingOrderEditarProvider.notifier).state = true;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      final mdata = e.response!.data;
      // e.message
      if (e.error.toString().isNotEmpty) {
        List<String> resmns = [];
        if (mdata.toString().contains("odoo.exceptions.UserError")) {
          resmns = mdata.toString().split("odoo.exceptions.UserError:");
        }
        if (mdata.toString().contains("odoo.exceptions.ValidationError")) {
          resmns = mdata.toString().split("odoo.exceptions.ValidationError:");
        }
        if (mdata.toString().contains("AttributeError:")) {
          resmns = mdata.toString().split("odoo.exceptions.ValidationError:");
        }

        errorMsn =
            " ${resmns.last.replaceAll("(", "").replaceAll(")", "").replaceAll("'", "")}";
        final errorMsnLn = errorMsn.trim().split("\\n");
        errorMsn = errorMsnLn.join("\n");
      } else {
        errorMsn = " ${mdata['error_descrip']}";
      }
      showErrorDialog(context, 'Error', errorMsn);
    } else {
      errorMsn = " ${e.message}";
      showErrorDialog(context, 'Error', errorMsn);
    }
    ref.read(dioErrorMsnProvider.notifier).state = errorMsn;

    ref.read(dioLoadingProvider.notifier).state = false;
  }
}

void putDespachoInProviders(WidgetRef ref, dynamic data) {
  var mMovimientoListado = darMoveListProviderNotifier(ref);
  var mDespacho = darDespachoActualFormularioProviderNotifier(ref);
  var mMovimiento = darMoveActualFormularioProviderNotifier(ref);

  mDespacho.state = PickingOrder.fromMap(data);
  mMovimientoListado.cargaRegistros(mDespacho.state.moveLinesData);
  mMovimiento.state = mMovimientoListado.getRegistros().first;
}

void getRemoteRecordDespacho(
    BuildContext context, WidgetRef ref, int id) async {
  final dioClient = ref.watch(dioHttpProvider);
  const String getTokenUrl = '/api/stock.picking';
  final url = dioClient.options.baseUrl + getTokenUrl;
  final filtermio = "[('id','=','$id')]";
  var errorMsn = "";
  try {
    final result = await dioClient
        .get(url, queryParameters: {'detail': true, 'filters': filtermio});

    if (result.statusCode == 200) {
      final mresults = result.data;
      final data = mresults['results'].first;
      putDespachoInProviders(ref, data);
      ref.watch(pickingOrderVistaFormularioProvider.notifier).state = true;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      final mdata = e.response!.data;
      errorMsn = " ${mdata['error_descrip']}";
      showErrorDialog(context, 'Error', errorMsn);
    } else {
      errorMsn = " ${e.message}";
      showErrorDialog(context, 'Error', errorMsn);
    }
    ref.read(dioErrorMsnProvider.notifier).state = errorMsn;

    ref.read(dioLoadingProvider.notifier).state = false;
  }
}

// void getRemoteListPickingOrders(
void getRemoteListPickingOrders(
    BuildContext context, WidgetRef ref, String busqueda) async {
  final dioClient = ref.watch(dioHttpProvider);
  const String getTokenUrl = '/api/stock.picking';
  final url = dioClient.options.baseUrl + getTokenUrl;
  final filtermio =
      "['|',('name','ilike','$busqueda'),'|',('origin','ilike','$busqueda'),'|',('cliente_name','ilike','$busqueda'),('cliente_ruc','ilike','$busqueda')]";
  var errorMsn = "";
  try {
    final result = await dioClient.get(url, queryParameters: {
      'offset': ref.watch(paginaActualPickingOrderListProvider),
      'limit': ref.watch(tamanioRegistrosPaginaPickingOrderListProvider),
      // 'field': pickingFields,
      'filters': filtermio
    });

    if (result.statusCode == 200) {
      final mresults = result.data;
      ref
          .watch(pickingOrderListProvider.notifier)
          .cargaRegistros(mresults['results']);
      ref
          .watch(totalRegistrosConsultadosPickingOrderListProvider.notifier)
          .state = mresults['total_count'];
      ref.watch(totalRegistrosCargadosPickingOrderListProvider.notifier).state =
          ref.watch(pickingOrderListProvider.notifier).getRegistros().length;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      final mdata = e.response!.data;
      errorMsn = " ${mdata['error_descrip']}";
      showErrorDialog(context, 'Error', errorMsn);
    } else {
      errorMsn = " ${e.message}";
      showErrorDialog(context, 'Error', errorMsn);
    }
    ref.read(dioErrorMsnProvider.notifier).state = errorMsn;

    ref.read(dioLoadingProvider.notifier).state = false;
  }
}

// void getRemoteOnePickingOrder(
//     BuildContext context, WidgetRef ref, int id) async {
//   final dioClient = ref.watch(dioHttpProvider);
//   final String getTokenUrl = '/api/stock.picking/$id';
//   final url = dioClient.options.baseUrl + getTokenUrl;
//   var errorMsn = "";
//   try {
//     final result = await dioClient.get(url, queryParameters: {
//       // 'field': pickingFields,
//     });

//     if (result.statusCode == 200) {
//       final mresults = result.data;
//       ref
//           .watch(pickingOrderListProvider.notifier)
//           .cargaRegistros(mresults['results']);
//       ref
//           .watch(totalRegistrosConsultadosPickingOrderListProvider.notifier)
//           .state = mresults['total_count'];
//       ref.watch(totalRegistrosCargadosPickingOrderListProvider.notifier).state =
//           ref.watch(pickingOrderListProvider.notifier).state.length;
//     }
//   } on DioError catch (e) {
//     if (e.response != null) {
//       final mdata = e.response!.data;
//       errorMsn = " ${mdata['error_descrip']}";
//       showErrorDialog(context, 'Error', errorMsn);
//     } else {
//       errorMsn = " ${e.message}";
//       showErrorDialog(context, 'Error', errorMsn);
//     }
//     ref.read(dioErrorMsnProvider.notifier).state = errorMsn;

//     ref.read(dioLoadingProvider.notifier).state = false;
//   }
// }
