import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import 'form_view_footer.dart';
import 'form_view.dart';
import '../../providers/sale_order_form_provider.dart';
import '../../vars/sale_order_global_vars.dart';
import 'form_view_header.dart';
import 'list_view_sale_order.dart';

class SaleOderWidget extends ConsumerStatefulWidget {
  const SaleOderWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<SaleOderWidget> createState() => _SaleOderWidgetState();
}

class _SaleOderWidgetState extends ConsumerState<SaleOderWidget>
    with PageMixin {
  @override
  Widget build(BuildContext context) {
    if (ref.watch(saleOrderVistaFormularioProvider)) {
      return ScaffoldPage.scrollable(
          padding: const EdgeInsets.only(
              left: 0.0, right: 0.0, bottom: 0.0, top: 10.0),
          key: viewSaleOrderFormPageKey,
          header: const HeaderFormularioVentas(),
          children: const [SaleOrderForm()],
          bottomBar: const FootFormularioVentas());
    } else {
      return ScaffoldPage.withPadding(
        padding: const EdgeInsets.only(
            left: 2.0, right: 2.0, bottom: 0.0, top: 10.0),
        key: saleOrderListViewPageKey,
        header: const HeaderListadoVentas(),
        content: const SaleOrderGrid(),
        bottomBar: const FootListadoVentas(),
      );
    }
  }
}
