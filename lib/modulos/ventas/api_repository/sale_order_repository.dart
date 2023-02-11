import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/core/utils/filter_model.dart';
import 'package:neo/modulos/ventas/data_sources/sale_order_datasource.dart';
import 'package:neo/widgets/error_dialog.dart';

import '../../../providers/dio_provider.dart';
import '../models/sale_order_model.dart';
import '../providers/sale_order_form_provider.dart';
import '../providers/sale_order_lines_list_provider.dart';
import '../providers/sale_order_list_provider.dart';

void seleccionarRegistrodeLista(BuildContext context, WidgetRef ref,
    SaleOrderListDataSource saleOrdersdatasource, int index) {
  if (index > 0) {
    final id = saleOrdersdatasource.recordData[index - 1]
        .getCells()
        .firstWhere((cel) => cel.columnName == 'id')
        .value as int;

    getRemoteSaleOrder(context, ref, id);
    // ref.read(vistaFormularioProvider.notifier).state = true;

    // final idVenta =
    // ref.watch(saleOrderFormProvider.notifier).state =
    // ref.watch(saleOrderListProvider.notifier).getRegistro(id);
  }
}

void getRemoteSaleOrder(BuildContext context, WidgetRef ref, int id) async {
  final dioClient = ref.watch(dioHttpProvider);
  const String getTokenUrl = '/api/sale.order';
  final url = dioClient.options.baseUrl + getTokenUrl;
  final filtermio = "[('id','=','$id')]";
  var errorMsn = "";
  try {
    final result = await dioClient
        .get(url, queryParameters: {'detail': true, 'filters': filtermio});

    if (result.statusCode == 200) {
      final mresults = result.data;
      final data = mresults['results'].first;
      ref.watch(saleOrderFormProvider.notifier).state = SaleOrder.fromMap(data);
      ref.read(saleOrderVistaFormularioProvider.notifier).state = true;
      final lineas =
          ref.watch(saleOrderFormProvider.notifier).state.orderLineData;
      ref.watch(saleOrderLineListProvider.notifier).cargaRegistros(lineas!);
      // final despachos =
      //     ref.watch(saleOrderFormProvider.notifier).state.pickingIdsData;
      // print(despachos);
      // ref.watch(pickingOrderListProvider.notifier).cargaRegistros(despachos!);
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

void getRemoteListSaleOrders(
  BuildContext context,
  WidgetRef ref,
  String busqueda, {
  List<FilterMenuItem>? listFilterOptions,
  String? listFilter,
  List<FilterMenuItem>? listSecondaryFilterOptions,
  String? listFilterSecondary,
}) async {
  final dioClient = ref.watch(dioHttpProvider);
  const String getTokenUrl = '/api/sale.order';
  final url = dioClient.options.baseUrl + getTokenUrl;
  String filter = "";
  String filterSecondary = "";
  if (listFilter.toString() != '') {
    filter = "," + darFiltro(listFilterOptions, listFilter.toString());
  }
  if (listFilterSecondary.toString() != '') {
    filterSecondary =
        darFiltro(listSecondaryFilterOptions, listFilterSecondary.toString());
  }
  final filtermio =
      "['|',('name','ilike','$busqueda'),'|',('cliente_name','ilike','$busqueda'),('cliente_ruc','ilike','$busqueda')$filter$filterSecondary]";
  var errorMsn = "";
  try {
    final result = await dioClient.get(url, queryParameters: {
      'offset': ref.watch(paginaActualSaleOrderListProvider),
      'limit': ref.watch(tamanioRegistrosPaginaSaleOrderListProvider),
      // 'field': saleFields,
      'filters': filtermio
    });

    if (result.statusCode == 200) {
      final mresults = result.data;
      ref
          .watch(saleOrderListProvider.notifier)
          .cargaRegistros(mresults['results']);
      ref.watch(totalRegistrosConsultadosSaleOrderListProvider.notifier).state =
          mresults['total_count'];
      ref.watch(totalRegistrosCargadosSaleOrderListProvider.notifier).state =
          ref.watch(saleOrderListProvider.notifier).state.length;
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

// void getRemoteOneSaleOrder(BuildContext context, WidgetRef ref, int id) async {
//   final dioClient = ref.watch(dioHttpProvider);
//   final String getTokenUrl = '/api/sale.order/$id';
//   final url = dioClient.options.baseUrl + getTokenUrl;
//   // final filtermio = "[('id','=','$id')]";
//   var errorMsn = "";
//   try {
//     final result = await dioClient.get(url, queryParameters: {
//       // 'offset': ref.watch(paginaActualProvider),
//       // 'limit': ref.watch(tamanioRegistrosPaginaProvider),
//       'field': saleFields,
//       // 'filters': filtermio
//     });

//     if (result.statusCode == 200) {
//       final mresults = result.data;
//       ref
//           .watch(saleOrderListProvider.notifier)
//           .cargaRegistros(mresults['results']);
//       ref.watch(totalRegistrosConsultadosSaleOrderListProvider.notifier).state =
//           mresults['total_count'];
//       ref.watch(totalRegistrosCargadosSaleOrderListProvider.notifier).state =
//           ref.watch(saleOrderListProvider.notifier).state.length;
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
