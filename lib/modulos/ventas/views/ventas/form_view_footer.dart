import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:neo/core/utils/device_info.dart';

import '../../providers/sale_order_form_provider.dart';
import '../../providers/sale_order_list_provider.dart';

class FootListadoVentas extends ConsumerWidget {
  const FootListadoVentas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPaginas =
        (ref.watch(totalRegistrosConsultadosSaleOrderListProvider) /
                ref.watch(tamanioRegistrosPaginaSaleOrderListProvider))
            .ceil();
    final paginaActual = ref.watch(paginaActualSaleOrderListProvider);
    final theme = FluentTheme.of(context);
    final myStyle =
        theme.typography.caption!.copyWith(fontWeight: FontWeight.w400);

    return DefaultTextStyle(
      style: myStyle,
      child: Column(
        children: [
          if (ref.watch(totalRegistrosConsultadosSaleOrderListProvider) >
              0) ...[
            Container(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(FluentIcons.page_left, size: 16.0),
                          onPressed: () => debugPrint('pressed button'),
                        ),
                        IconButton(
                          icon: const Icon(FluentIcons.page_right, size: 20.0),
                          onPressed: () => debugPrint('pressed button'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text('Pagina ${paginaActual + 1} de  $totalPaginas ',
                        style: myStyle),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      'Mostrando ${ref.watch(totalRegistrosCargadosSaleOrderListProvider)} de ${ref.watch(totalRegistrosConsultadosSaleOrderListProvider).toString()}',
                      style: myStyle),
                ],
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text('Sin registros que mostrar', style: myStyle),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class FootFormularioVentas extends ConsumerWidget {
  const FootFormularioVentas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);
    final myStyle =
        theme.typography.caption!.copyWith(fontWeight: FontWeight.w400);
    final registroActual = ref.watch(saleOrderFormProvider);
    final isPhone = DeviceScreen.isPhone(context);
    if (isPhone) {
      return Container();
    } else {
      return DefaultTextStyle(
        style: myStyle,
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                        'Creado por ${registroActual.createUid} el  ${registroActual.createDate}',
                        style: myStyle),
                  ),
                  Text(
                      'Modificado por ${registroActual.createUid} el  ${registroActual.writeDate}',
                      style: myStyle),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
