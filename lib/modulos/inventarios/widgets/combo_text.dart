import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spflutter_number_picker/spflutter_number_picker.dart';

import 'package:flutter/material.dart' show Material;

class ChooseNumber extends ConsumerStatefulWidget {
  const ChooseNumber({
    super.key,
    required this.inicio,
    required this.fin,
    this.actual = 0,
    this.constraints,
    this.onChanged,
  });
  final BoxConstraints? constraints;
  final double inicio;
  final double fin;
  final double actual;
  final void Function(double)? onChanged;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChooseNumberState();
}

class _ChooseNumberState extends ConsumerState<ChooseNumber> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    // final theme = FluentTheme.of(context);

    // double? _resetValue;
    // double? XX;
    // return ConstrainedBox(
    //   constraints: widget.constraints ?? BoxConstraints(maxWidth: 30),
    //   child: Material(
    //     child: NumberPicker(
    //       theme: NumberSelectionTheme(
    //           draggableCircleColor: Colors.blue,
    //           iconsColor: Colors.white,
    //           numberColor: Colors.white,
    //           backgroundColor: Colors.grey,
    //           outOfConstraintsColor: Colors.red),
    //       interval: 1,
    //       initialValue: 0,
    //       resetValue: _resetValue,
    //       valueController: textEditingController,
    //       maxValue: 10.2,
    //       direction: Axis.horizontal,
    //       withSpring: true,
    //       onChanged: (double value) {
    //         XX = 23;
    //         setState(() {});
    //         print("value: $value");
    //       },
    //       enableOnOutOfConstraintsAnimation: true,
    //       onOutOfConstraints: () => print("This value is too high or too low"),
    //     ),
    return ConstrainedBox(
      constraints: widget.constraints ?? const BoxConstraints(maxWidth: 30),
      child: Material(
        child: NumberPicker(
          // theme: NumberSelectionTheme(
          //     draggableCircleColor: theme.accentColor,
          //     iconsColor: Colors.white,
          //     numberColor: Colors.white,
          //     backgroundColor: theme.accentColor.lightest,
          //     iconsDisableColor: Colors.white,
          //     outOfConstraintsColor: Colors.orange),
          interval: 1,
          initialValue: widget.inicio,
          resetValue: widget.actual,
          // resetValue: _resetValue,
          valueController: textEditingController,
          maxValue: widget.fin,
          iconEmpty: FluentIcons.calculator_subtract,
          iconAdd: FluentIcons.add,
          iconMin: FluentIcons.calculator_subtract,
          direction: Axis.horizontal,
          withSpring: true,
          // onChanged: onChanged,
          onChanged: (double value) {
            debugPrint("value: $value");
          },
          enableOnOutOfConstraintsAnimation: false,
          onOutOfConstraints: () =>
              debugPrint("This value is too high or too low"),
        ),
      ),
    );
  }
}

class NumberChoose extends ConsumerWidget {
  const NumberChoose({
    super.key,
    required this.inicio,
    required this.fin,
    this.actual = 0,
    this.constraints,
    this.onChanged,
  });
  final BoxConstraints? constraints;
  final double inicio;
  final double fin;
  final double actual;
  final void Function(double)? onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController textEditingController =
        TextEditingController(text: actual.toString());
    final theme = FluentTheme.of(context);

    return Material(
      child: ConstrainedBox(
        constraints: constraints ?? const BoxConstraints(maxWidth: 30),
        child: NumberPicker(
          theme: NumberSelectionTheme(
              draggableCircleColor: theme.accentColor,
              iconsColor: Colors.white,
              numberColor: Colors.white,
              backgroundColor: theme.accentColor.lightest,
              iconsDisableColor: Colors.white,
              outOfConstraintsColor: Colors.orange),
          interval: 1,
          initialValue: inicio,
          resetValue: actual,
          // resetValue: _resetValue,
          valueController: textEditingController,
          maxValue: fin,
          iconEmpty: FluentIcons.calculator_subtract,
          iconAdd: FluentIcons.add,
          iconMin: FluentIcons.calculator_subtract,
          direction: Axis.horizontal,
          withSpring: true,
          // onChanged: onChanged,
          onChanged: (double value) {
            debugPrint("value: $value");
          },
          enableOnOutOfConstraintsAnimation: false,
          onOutOfConstraints: () =>
              debugPrint("This value is too high or too low"),
        ),
      ),
    );
  }
}
