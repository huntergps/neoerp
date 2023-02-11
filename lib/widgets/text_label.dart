import 'package:fluent_ui/fluent_ui.dart';

class TextLabelLeft extends StatelessWidget {
  const TextLabelLeft({
    Key? key,
    required this.label,
    required this.value,
    this.width,
    this.widthValue,
    this.valueStyle,
    this.labelStyle,
    this.valueTextAlign,
    this.labelTextAlign,
    this.fontSizeLabel,
    this.fontSizeValue = 0.0,
  }) : super(key: key);

  final String label;
  final String value;
  final double? width;
  final double? widthValue;
  final double? fontSizeLabel;
  final double? fontSizeValue;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;
  final TextAlign? valueTextAlign;
  final TextAlign? labelTextAlign;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final themeCaption = theme.typography.caption!;
    final titleColor = themeCaption.color!.withOpacity(0.5);
    // final isPhone = DeviceScreen.isPhone(context);
    final styloValor = fontSizeValue! > 0
        ? theme.typography.caption!.copyWith(fontSize: fontSizeValue)
        : theme.typography.caption;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          // color: Colors.amber,
          width: width ?? 85,
          child: Text(
            overflow: TextOverflow.ellipsis,
            textAlign: labelTextAlign,
            label,
            softWrap: true,
            maxLines: 1,
            style: labelStyle ??
                theme.typography.caption!
                    .copyWith(color: titleColor, fontSize: fontSizeLabel),
          ),
        ),
        const SizedBox(width: 3),
        if (widthValue != null) ...[
          SizedBox(
            width: widthValue,
            child: Text(
              overflow: TextOverflow.ellipsis,
              textAlign: valueTextAlign,
              value,
              softWrap: true,
              maxLines: 1,
              style: valueStyle ?? styloValor,
            ),
          )
        ] else ...[
          Expanded(
            child: Text(
              value,
              style: valueStyle ?? styloValor,
            ),
          ),
        ],
      ],
    );
  }
}

class TextLabelDown extends StatelessWidget {
  const TextLabelDown({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final themeCaption = theme.typography.caption!;
    final titleColor = themeCaption.color!.withOpacity(0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.typography.caption!.copyWith(color: titleColor),
        ),
      ],
    );
  }
}

class TextLabel extends StatelessWidget {
  const TextLabel({
    Key? key,
    required this.label,
    required this.value,
    this.width,
    this.widthValue,
    this.valueStyle,
    this.labelStyle,
    this.valueTextAlign,
    this.labelTextAlign,
    this.fontSizeLabel,
    this.fontSizeValue,
  }) : super(key: key);

  final String label;
  final String value;
  final double? width;
  final double? widthValue;
  final double? fontSizeLabel;
  final double? fontSizeValue;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;
  final TextAlign? valueTextAlign;
  final TextAlign? labelTextAlign;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final themeCaption = theme.typography.caption!;
    final titleColor = themeCaption.color!.withOpacity(0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   width: width ?? 85,
        //   child: Text(
        //     overflow: TextOverflow.ellipsis,
        //     textAlign: labelTextAlign,
        //     label,
        //     softWrap: true,
        //     maxLines: 1,
        //     style: labelStyle ??
        //         theme.textTheme.caption!
        //             .copyWith(color: titleColor, fontSize: fontSizeLabel),
        //   ),
        // ),
        if (width != null) ...[
          SizedBox(
            width: widthValue,
            child: Text(
              overflow: TextOverflow.ellipsis,
              textAlign: labelTextAlign,
              label,
              softWrap: true,
              maxLines: 1,
              style: labelStyle ??
                  themeCaption.copyWith(
                      color: titleColor, fontSize: fontSizeLabel),
            ),
          ),
        ] else ...[
          Expanded(
            child: Text(label,
                style: labelStyle ??
                    themeCaption.copyWith(
                      color: titleColor,
                      fontSize: fontSizeLabel,
                    )),
          )
        ],
        if (widthValue != null) ...[
          SizedBox(
            width: widthValue,
            child: Text(
              // overflow: TextOverflow.ellipsis,
              textAlign: valueTextAlign,
              value,
              softWrap: true,
              // maxLines: 1,
              style:
                  valueStyle ?? themeCaption.copyWith(fontSize: fontSizeValue),
            ),
          )
        ] else ...[
          Expanded(
            child: Text(
              value,
              style:
                  valueStyle ?? themeCaption.copyWith(fontSize: fontSizeValue),
            ),
          ),
        ],
      ],
    );
  }
}
