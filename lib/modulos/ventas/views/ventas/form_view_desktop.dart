import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo/widgets/text_label.dart';

import '../../vars/sale_order_list_fields.dart';
import '../../models/sale_order_model.dart';

class SaleOrderMainInfoDesktop extends StatelessWidget {
  const SaleOrderMainInfoDesktop({this.registroActual, Key? key})
      : super(key: key);
  final SaleOrder? registroActual;
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    final clienteActual = registroActual!.partnerIdData!.first;
    final colorFondo = getColorSaleOrderState(context, registroActual!.state);
    final colorLinea =
        getColorSaleOrderState(context, registroActual!.state, fondo: false);

    return Mica(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children: [
                TextLabel(
                    width: 100,
                    widthValue: 100,
                    label: 'Ruc',
                    value: '${clienteActual.vat}'),
                const SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: TextLabel(
                      width: 100,
                      widthValue: 900,
                      label: 'Cliente',
                      value: '${clienteActual.name}'),
                ),
                const SizedBox(width: 8),
                Card(
                  padding: const EdgeInsets.only(
                      left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                  borderColor: colorLinea,
                  backgroundColor: colorFondo,
                  child: Text(
                    stateSaleOrderField[registroActual!.state]!.toUpperCase(),
                    style: theme.typography.subtitle,
                  ),
                  // child: TextLabel(
                  //   width: 60,
                  //   widthValue: 124,
                  //   label: 'Estado',
                  //   fontSizeLabel: 10.0,
                  //   fontSizeValue: 14.0,
                  //   value:
                  //       '${stateOrderField[registroActual!.state]!.toUpperCase()}',
                  // ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextLabel(
                      width: 100,
                      widthValue: 580,
                      label: 'Telefonos',
                      value: '${clienteActual.mobile} ${clienteActual.phone}'),
                ),
                Expanded(
                  flex: 2,
                  child: TextLabel(
                      width: 50,
                      widthValue: 580,
                      label: 'Email',
                      value: '${clienteActual.email}'),
                ),
                const SizedBox(width: 4),
                TextLabel(
                    // fontSizeValue: 11,
                    width: 145,
                    widthValue: 145,
                    label: 'Acuerdo de Pago',
                    value: '${registroActual!.acuerdoName}'),
                const SizedBox(width: 4),
                TextLabel(
                    // fontSizeValue: 11,
                    width: 100,
                    widthValue: 100,
                    label: 'Plazo de Pago',
                    value: '${registroActual!.paymentTermName}'),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Expanded(
                  // flex: 2,
                  child: TextLabel(
                      width: 50,
                      widthValue: 580,
                      label: 'Direccion',
                      value: '${clienteActual.street}, ${clienteActual.city}'),
                ),
                // const SizedBox(width: 4),
                // Expanded(
                //   child: Container(
                //     color: Colors.blue,
                //   ),
                // ),
                TextLabel(
                    // fontSizeValue: 11,
                    width: 280,
                    widthValue: 280,
                    label: 'Vendedor',
                    value: '${registroActual!.userNameLogin}'),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextLabel(
                    width: 180,
                    widthValue: 180,
                    label: 'Fecha de Orden',
                    value: '${registroActual!.dateOrder}'),
                TextLabel(
                    width: 180,
                    widthValue: 180,
                    label: 'Fecha de Factura',
                    value: '${registroActual!.invoiceDate}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color? getColorSaleOrderState(BuildContext context, String? state,
    {bool fondo = true}) {
  final theme = FluentTheme.of(context);
  Color? color;
  switch (state) {
    case 'draft':
      {
        color = fondo ? Colors.red.lightest : Colors.red.darkest;
      }
      break;

    case 'sale':
      {
        color = fondo ? Colors.green.lightest : Colors.green.darkest;
      }
      break;
    case 'approved':
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

  // 'draft': 'Borrador',
  // 'sent': 'Enviado',
  // 'sale': 'Pedido de Venta',
  // 'done': 'Bloqueado',
  // 'waiting_approval': 'A la espera de Aprobación',
  // 'approved': 'Aprobado',
  // 'posted': 'Hecho',
  // 'rejected': 'Rechazado',
  // 'cancel': 'Cancelado',
}
