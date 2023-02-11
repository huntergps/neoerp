import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/core/utils/device_info.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import '../../providers/sale_order_form_provider.dart';
import 'form_view_desktop.dart';
import 'form_view_mobil.dart';
import 'form_view_totals.dart';
import 'list_view_lines.dart';

const double dataPagerHeight = 235;

class SaleOrderForm extends ConsumerStatefulWidget {
  const SaleOrderForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaleOrderFormState();
}

class _SaleOrderFormState extends ConsumerState<SaleOrderForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registroActual = ref.watch(saleOrderFormProvider);
    final isPhone = DeviceScreen.isPhone(context);
    final altoNormal = isPhone ? 250.00 : 400.00;
    final double alto = registroActual.orderLineData!.length > 10
        ? 31 * registroActual.orderLineData!.length.toDouble()
        : altoNormal;
    return Column(
      children: [
        if (isPhone) ...[
          SaleOrderMainInfoMobil(registroActual: registroActual)
        ] else ...[
          SaleOrderMainInfoDesktop(registroActual: registroActual)
        ],
        SizedBox(height: alto, child: const SaleOrderLinesGrid()),
        SaleOrderTotalInfo(registroActual: registroActual)
      ],
    );
  }
}
