import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import '../../providers/picking_order_form_provider.dart';
import '../../vars/picking_order_global_vars.dart';
import 'form_view_footer.dart';
import 'form_view.dart';
import 'form_view_header.dart';
import 'list_view.dart';

class OrdenDespachoWidget extends ConsumerStatefulWidget {
  const OrdenDespachoWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdenDespachoWidget> createState() =>
      _OrdenDespachoWidgetState();
}

class _OrdenDespachoWidgetState extends ConsumerState<OrdenDespachoWidget>
    with PageMixin {
  @override
  Widget build(BuildContext context) {
    if (ref.watch(pickingOrderVistaFormularioProvider)) {
      final registroActualDesdeDespachos = ref.watch(pickingOrderFormProvider);
      return ScaffoldPage.scrollable(
          padding: const EdgeInsets.only(
              left: 0.0, right: 0.0, bottom: 0.0, top: 10.0),
          key: viewPickingOrderFormPageKey,
          header: HeaderFormularioDespachos(
              registroActual: registroActualDesdeDespachos),
          children: [
            DespachoForm(registroActual: registroActualDesdeDespachos)
          ],
          bottomBar: FootFormularioDespachos(
              registroActual: registroActualDesdeDespachos));
    } else {
      return ScaffoldPage.withPadding(
        padding: const EdgeInsets.only(
            left: 2.0, right: 2.0, bottom: 0.0, top: 10.0),
        key: pickingOrderListViewPageKey,
        header: const HeaderListadoDespachos(),
        content: const PickingOrderGrid(),
        bottomBar: const FootListadoDespachos(),
      );
    }
  }
}
