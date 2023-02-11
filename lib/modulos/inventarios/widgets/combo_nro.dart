import 'package:fluent_ui/fluent_ui.dart';

// double fontSize = 20.0;

List<double> generarNros(final double inicio, final double fin) {
  // final double length = fin - inicio;

  // var list = List<double>.generate(length.toInt(), (inicio) => inicio + 1);
  var list = [for (var i = inicio; i < fin + 1; i += 1) i];

  return list;
}

class ComboNumero extends StatefulWidget {
  const ComboNumero({
    Key? key,
    required this.inicio,
    required this.fin,
    required this.actual,
    required this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  final double inicio;
  final double fin;
  final double actual;
  final String Function(String) onFieldSubmitted;
  final void Function(double?)? onChanged;
  @override
  State<ComboNumero> createState() => _ComboNumeroState();
}

class _ComboNumeroState extends State<ComboNumero> {
  @override
  Widget build(BuildContext context) {
    final fontSizes = generarNros(widget.inicio, widget.fin);
    // var nroActual = widget.actual;
    return EditableComboBox<double>(
      value: widget.actual,
      items: fontSizes.map<ComboBoxItem<double>>((e) {
        return ComboBoxItem<double>(
          child: Text('$e'),
          value: e.toDouble(),
        );
      }).toList(),
      onChanged: widget.onChanged,
      placeholder: const Text('Select a font size'),
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
