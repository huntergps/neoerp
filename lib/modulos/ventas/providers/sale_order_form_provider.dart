import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sale_order_model.dart';

/// *************************************************************************/
/// PROVIDERS USADOS PARA VISTA FORMULARIO
/// *************************************************************************/
final saleOrderVistaFormularioProvider = StateProvider<bool>(
  (ref) => false,
);

final saleOrderFormProvider = StateProvider<SaleOrder>(
  (ref) => SaleOrder(),
);
