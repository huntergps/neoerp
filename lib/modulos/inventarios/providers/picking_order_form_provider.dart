import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/picking_model.dart';

/// *************************************************************************/
/// PROVIDERS USADOS PARA VISTA FORMULARIO
/// *************************************************************************/
final pickingOrderVistaFormularioProvider = StateProvider<bool>(
  (ref) => false,
);

final pickingOrderEditarProvider = StateProvider<bool>(
  (ref) => false,
);

final pickingOrderFormProvider = StateProvider<PickingOrder>(
  (ref) => PickingOrder(),
);

final pickingOrderFormDesdeVentasProvider = StateProvider<PickingOrder>(
  (ref) => PickingOrder(),
);
