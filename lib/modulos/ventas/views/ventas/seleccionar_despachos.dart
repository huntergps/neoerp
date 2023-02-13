import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/modulos/inventarios/models/picking_model_list.dart';
import 'package:neo/providers/providers_general.dart';
import 'package:neo/modulos/inventarios/providers/picking_order_list_provider.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:neo/widgets/text_label.dart';

import '../../../inventarios/api_repository/picking_order_repository.dart';
import '../../../inventarios/vars/picking_list_fields.dart';

// 'draft': 'Borrador',
// 'confirmed': 'Espera',
// 'assigned': 'Preparado',
// 'done': 'Hecho',
// 'approval': 'En esamblaje',
// 'approved': 'Envio Interno',
// 'rejected': 'Envio Externo',
// 'cancel': 'Cancelado',
// 'delivered': 'Entregado',

Color? getColorPickingOrderState(BuildContext context, String? state,
    {bool fondo = true}) {
  final theme = FluentTheme.of(context);
  Color? color;
  switch (state) {
    case 'draft':
      {
        color = fondo ? Colors.red : Colors.red.darkest;
      }
      break;

    case 'done':
      {
        color = fondo ? Colors.green : Colors.green.darkest;
      }
      break;
    case 'confirmed':
      {
        color = fondo ? Colors.blue.lightest : Colors.blue.darkest;
      }
      break;
    case 'assigned':
      {
        color = fondo ? Colors.blue.lightest : Colors.blue.darkest;
      }
      break;

    case 'cancel':
      {
        color = fondo ? Colors.orange.lightest : Colors.orange.darkest;
      }
      break;
    default:
      {
        color = fondo
            ? theme.scaffoldBackgroundColor
            : theme.typography.title!.color;
      }
      break;
  }
  return color;
}

List<CommandBarItem> seleccionDespachosBotones(
    BuildContext context, WidgetRef ref, List<PickingOrderList>? despachos) {
  final theme = FluentTheme.of(context);
  if (despachos!.isEmpty) {
    return [];
  } else {
    return despachos.map((despacho) {
      final colorFondo = getColorPickingOrderState(context, despacho.state);
      return CommandBarButton(
        icon: Icon(
          FluentIcons.change_entitlements,
          size: 24.0,
          color: colorFondo,
        ),
        label: Column(
          children: [
            Text(
              '${despacho.name}',
              style: theme.typography.caption!.copyWith(fontSize: 12),
            ),
            Text(
              statePickingOrderField[despacho.state]!.toUpperCase(),
              style: theme.typography.caption!.copyWith(fontSize: 10),
            ),
          ],
        ),
        // subtitle: Text('${despacho.id}'),
        onPressed: () {
          // saleOrderPickingOrderFormProvider
          var despachoId = despacho.id?.toInt() ?? 0;

          ref.read(tipoPantalla.notifier).state = "sale_despacho_form";
          getRemoteRecordDespacho(context, ref, despachoId);
        },
      );
    }).toList();
  }
}

class SeleccionDespachosVertical extends ConsumerWidget {
  const SeleccionDespachosVertical({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final despachos =
        ref.read(pickingOrderListProvider.notifier).getRegistros();
    return ListView.builder(
        itemCount: despachos.length,
        itemBuilder: (context, index) {
          final despacho = despachos[index];
          return TileDespachosVertical(
            despacho: despacho,
            onPressed: () {
              ref.read(tipoPantalla.notifier).state = "despacho_form";
            },
          );
        });
  }
}

class TileDespachosVertical extends StatelessWidget {
  const TileDespachosVertical({
    Key? key,
    required this.despacho,
    this.onPressed,
  }) : super(key: key);

  final PickingOrderList despacho;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final themeCaption = theme.typography.caption!;
    final titleColor = themeCaption.color!.withOpacity(0.5);

    return Card(
      child: ListTile(
        leading: Column(
          children: [
            const Icon(
              FluentIcons.change_entitlements,
              size: 24.0,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${despacho.id}',
              style: themeCaption.copyWith(
                color: titleColor,
              ),
            )
          ],
        ),
        title: TextLabel(
          width: 100,
          widthValue: 900,
          label: 'Despacho',
          value: '${despacho.name}',
        ),
        subtitle: TextLabelLeft(
          width: 60,
          widthValue: 90,
          label: 'Estado',
          value: '${statePickingOrderField[despacho.state]}',
        ),
        trailing: const Icon(
          FluentIcons.double_chevron_right12,
          size: 32.0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
