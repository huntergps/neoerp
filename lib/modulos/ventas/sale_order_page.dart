import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/providers/providers_general.dart';
import 'package:neo/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import '../inventarios/providers/picking_order_form_provider.dart';
import '../inventarios/vars/picking_order_global_vars.dart';
import '../inventarios/views/despachos/form_view.dart';
import '../inventarios/views/despachos/form_view_footer.dart';
import '../inventarios/views/despachos/form_view_header.dart';
import 'views/ventas/sale_order_widget.dart';

class SaleOderPage extends ConsumerStatefulWidget {
  const SaleOderPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SaleOderPage> createState() => _SaleOderPageState();
}

class _SaleOderPageState extends ConsumerState<SaleOderPage> with PageMixin {
  @override
  Widget build(BuildContext context) {
    if (ref.watch(tipoPantalla) == "sale_despacho_form") {
      final registroActualDesdeVentas =
          ref.watch(pickingOrderFormDesdeVentasProvider);
      return ScaffoldPage.scrollable(
          padding: const EdgeInsets.only(
              left: 0.0, right: 0.0, bottom: 0.0, top: 10.0),
          key: viewPickingOrderFormPageKey,
          header: HeaderFormularioDespachos(
              registroActual: registroActualDesdeVentas),
          children: [
            registroActualDesdeVentas == null
                ? const Center(child: ProgressRing())
                : DespachoForm(registroActual: registroActualDesdeVentas)
          ],
          bottomBar: FootFormularioDespachos(
              registroActual: registroActualDesdeVentas));
    } else {
      return SaleOderWidget();
    }
  }
}
