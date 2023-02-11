import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo/core/utils/device_info.dart';
import 'package:neo/widgets/text_label.dart';

import '../../models/sale_order_model.dart';

class SaleOrderTotalInfo extends StatelessWidget {
  const SaleOrderTotalInfo({Key? key, required this.registroActual, this.color})
      : super(key: key);
  final SaleOrder? registroActual;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isPhone = DeviceScreen.isPhone(context);

    return Card(
      padding: isPhone
          ? const EdgeInsets.only(right: 8.0)
          : const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          if (isPhone == false) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor),
                borderRadius: BorderRadius.circular(5),
                color: theme.brightness.isDark
                    ? theme.scaffoldBackgroundColor
                    : theme.activeColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabelLeft(
                      width: 100,
                      widthValue: 70,
                      label: 'Margen',
                      value: registroActual!.margin!.toStringAsFixed(2),
                      valueTextAlign: TextAlign.right,
                      labelTextAlign: TextAlign.right,
                    ),
                    TextLabelLeft(
                      width: 100,
                      widthValue: 70,
                      label: '% Utilidad ',
                      value:
                          '${registroActual?.marginPercentGeneral!.toStringAsFixed(2)}',
                      valueTextAlign: TextAlign.right,
                      labelTextAlign: TextAlign.right,
                    ),
                    TextLabelLeft(
                      width: 100,
                      widthValue: 70,
                      label: 'Costo de Venta',
                      value: registroActual!.costTotal!.toStringAsFixed(2),
                      valueTextAlign: TextAlign.right,
                      labelTextAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextLabelLeft(
                    width: 160,
                    widthValue: 70,
                    label: 'Subtotal gravado con I.V.A',
                    value: registroActual!.baseimpgrav!.toStringAsFixed(2),
                    valueTextAlign: TextAlign.right,
                    labelTextAlign: TextAlign.right,
                  ),
                  TextLabelLeft(
                    width: 160,
                    widthValue: 70,
                    label: 'Subtotal I.V.A. 0%',
                    value:
                        '${registroActual?.baseimponible!.toStringAsFixed(2)}',
                    valueTextAlign: TextAlign.right,
                    labelTextAlign: TextAlign.right,
                  ),
                ],
              ),
            )
          ],
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // if (isPhone) ...[
                //   TextLabelLeft(
                //     width: 160,
                //     widthValue: 70,
                //     label: 'Subtotal gravado con I.V.A',
                //     value: registroActual!.baseimpgrav!.toStringAsFixed(2),
                //     valueTextAlign: TextAlign.right,
                //     labelTextAlign: TextAlign.right,
                //   ),
                //   TextLabelLeft(
                //     width: 160,
                //     widthValue: 70,
                //     label: 'Subtotal I.V.A. 0%',
                //     value:
                //         '${registroActual?.baseimponible!.toStringAsFixed(2)}',
                //     valueTextAlign: TextAlign.right,
                //     labelTextAlign: TextAlign.right,
                //   ),
                // ],
                TextLabelLeft(
                  width: 100,
                  widthValue: 70,
                  label: 'SubTotal',
                  value: registroActual!.subtotalSri!.toStringAsFixed(2),
                  valueTextAlign: TextAlign.right,
                  labelTextAlign: TextAlign.right,
                ),
                TextLabelLeft(
                  width: 100,
                  widthValue: 70,
                  label: 'Total Descuento',
                  value:
                      '${registroActual?.amountDiscount!.toStringAsFixed(2)}',
                  valueTextAlign: TextAlign.right,
                  labelTextAlign: TextAlign.right,
                ),
                TextLabelLeft(
                  width: 100,
                  widthValue: 70,
                  label: 'Monto I.V.A',
                  value: registroActual!.montoiva!.toStringAsFixed(2),
                  valueTextAlign: TextAlign.right,
                  labelTextAlign: TextAlign.right,
                ),
                const SizedBox(height: 5),
                TextLabelLeft(
                  width: 100,
                  widthValue: 70,
                  label: 'TOTAL',
                  value: registroActual!.totalSri!.toStringAsFixed(2),
                  fontSizeLabel: 14,
                  fontSizeValue: 14,
                  valueTextAlign: TextAlign.right,
                  labelTextAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
