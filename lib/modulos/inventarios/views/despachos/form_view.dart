import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo/core/utils/device_info.dart';
import 'package:neo/providers/dio_provider.dart';

import '../../api_repository/dar_tipo_provider.dart';
import '../../models/picking_model.dart';
import '../../models/stock_move_list_model.dart';
import '../../widgets/movi_panel_info.dart';
import 'form_view_desktop.dart';
import 'form_view_mobil.dart';
import 'move_list.dart';

const double dataPagerHeight = 235;

class DespachoForm extends ConsumerStatefulWidget {
  const DespachoForm({
    super.key,
    required this.registroActual,
  });

  final PickingOrder registroActual;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DespachoFormFormState();
}

class _DespachoFormFormState extends ConsumerState<DespachoForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(dioLoadingProvider) == true) {
      return const Center(child: ProgressRing());
    } else {
      final registroActual = widget.registroActual;

      final List<StockMoveList>? moves = registroActual.moveLinesData ?? [];

      final StockMoveList move = darMoveActualFormulario(ref);
      final isPhone = DeviceScreen.isPhone(context);
      final altoNormal = isPhone ? 250.00 : 550.00;
      final double alto =
          moves!.length > 10 ? 31 * moves.length.toDouble() : altoNormal;
      return Column(
        children: [
          // DespachooMainInfoDesktop(registroActual: registroActual),
          if (isPhone) ...[
            DespachoMainInfoMobil(registroActual: registroActual)
          ] else ...[
            DespachoMainInfoDesktop(registroActual: registroActual)
          ],
          SizedBox(
              height: alto,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: Card(
                      padding: const EdgeInsets.all(8.0),
                      child: StockMoveListGrid(moveListRecords: moves),
                    ),
                  ),
                  if (isPhone == false) ...[
                    const SizedBox(width: 4.0),
                    Expanded(
                      flex: 2,
                      child: PanelMoveInfo(
                        move: move,
                      ),
                    ),
                  ],
                ],
              )),
        ],
      );
    }
    // });
    //
    // ],
    // );
  }
}
