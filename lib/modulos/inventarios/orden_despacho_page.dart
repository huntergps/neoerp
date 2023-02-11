import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import 'views/despachos/orden_despacho_widget.dart';

class OrdenDespachoPage extends ConsumerStatefulWidget {
  const OrdenDespachoPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdenDespachoPage> createState() => _OrdenDespachoPageState();
}

class _OrdenDespachoPageState extends ConsumerState<OrdenDespachoPage>
    with PageMixin {
  @override
  Widget build(BuildContext context) {
    // if (ref.watch(indexMenuProvider) == 3) {
    return OrdenDespachoWidget();
    // } else {
    //   return EmptyPage();
    // }
  }
}
