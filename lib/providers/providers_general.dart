import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexMenuProvider = StateProvider<int>(
  (ref) => 0,
);

final tipoPantalla = StateProvider<String>(
  (ref) => "ventas",
);
