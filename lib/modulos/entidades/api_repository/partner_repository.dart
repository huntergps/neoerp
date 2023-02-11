import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/common/models/user_model.dart';
import 'package:neo/providers/dio_provider.dart';

import '../../common/models/lot_model.dart';
import '../../inventarios/models/stock_move_line_list_model.dart';
import '../models/partner_model.dart';
import '../providers/partner_list_provider.dart';

Future<List<StockLot>> getDataComboCodBar(
  WidgetRef ref,
  busqueda,
  int producId,
  int locationId,
  List<StockMoveLineList>? moveListRecords,
) async {
  final dioClient = ref.watch(dioHttpProvider);
  const String getTokenUrl = '/api/stock.production.lot';
  final url = dioClient.options.baseUrl + getTokenUrl;
  final filtermio =
      "[('name','ilike','$busqueda'),('product_id','=',$producId)]";
  final response = await dioClient.get(url, queryParameters: {
    'offset': 0,
    'limit': 3000, //ref.watch(tamanioRegistrosPaginaPartnerListProvider),
    'filters': filtermio
  });

  final mresults = response.data;
  final data = mresults['results'];
  if (data != null) {
    final mlist = StockLot.fromJsonList(data).toList();
    if (mlist.isEmpty) return [];
    final estaEnPantalla = moveListRecords!.map((e) => e.lotId).toList();
    final mlist2 =
        mlist.where((e) => e.locationIds!.contains(locationId)).toList();
    final mm = mlist2.where((e) {
      return estaEnPantalla.contains(e.id) == false;
    }).toList();
    return mm;
  }

  return [];
}

Future<List<UserList>> getDataComboUsuario(WidgetRef ref, busqueda) async {
  final dioClient = ref.watch(dioHttpProvider);
  const String getTokenUrl = '/api/res.users';
  final url = dioClient.options.baseUrl + getTokenUrl;
  final filtermio =
      "['|',('name','ilike','$busqueda'),('login','ilike','$busqueda'),('share','!=','1')]";
  final response = await dioClient.get(url, queryParameters: {
    'offset': ref.watch(paginaActualPartnerListProvider),
    'limit': ref.watch(tamanioRegistrosPaginaPartnerListProvider),
    'filters': filtermio
  });

  final mresults = response.data;

  final data = mresults['results'];
  if (data != null) {
    return UserList.fromJsonList(data);
  }

  return [];
}

Future<List<PartnerList>> getDataComboTransportista(
    WidgetRef ref, busqueda) async {
  final dioClient = ref.watch(dioHttpProvider);
  const String getTokenUrl = '/api/res.partner';
  final url = dioClient.options.baseUrl + getTokenUrl;
  final filtermio =
      "['|',('name','ilike','$busqueda'),('vat','ilike','$busqueda'),('es_transportista','=','1')]";
  final response = await dioClient.get(url, queryParameters: {
    'offset': ref.watch(paginaActualPartnerListProvider),
    'limit': ref.watch(tamanioRegistrosPaginaPartnerListProvider),
    'filters': filtermio
  });

  final mresults = response.data;

  final data = mresults['results'];
  if (data != null) {
    return PartnerList.fromJsonList(data);
  }

  return [];
}


// getRemoteListPartners async(
//   BuildContext context,
//   WidgetRef ref,
//   String busqueda,
// ) async {
//   final dioClient = ref.watch(dioHttpProvider);
//   const String getTokenUrl = '/api/res.partner';
//   final url = dioClient.options.baseUrl + getTokenUrl;
//   final filtermio =
//       "['|',('name','ilike','$busqueda'),('vat','ilike','$busqueda')]";
//   var errorMsn = "";
//   try {
//     final result = dioClient.get(url, queryParameters: {
//       'offset': ref.watch(paginaActualPartnerListProvider),
//       'limit': ref.watch(tamanioRegistrosPaginaPartnerListProvider),
//       'filters': filtermio
//     });

//     if (result.statusCode == 200) {
//       final mresults = result.data;

//       ref
//           .watch(partnerListProvider.notifier)
//           .cargaRegistros(mresults['results']);
//       // return ref.watch(partnerListProvider.notifier).s;
//       // ref.watch(totalRegistrosConsultadosPartnerListProvider.notifier).state =
//       //     mresults['total_count'];
//       // ref.watch(totalRegistrosCargadosPartnerListProvider.notifier).state =
//       //     ref.watch(partnerListProvider.notifier).state.length;
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
