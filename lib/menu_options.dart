import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:url_launcher/link.dart';

import 'modulos/inicio.dart';

import 'routes/ventas.dart' deferred as ventas;
import 'routes/inventarios.dart' deferred as inventarios;
// import 'routes/servicio_tecnico.dart' deferred as sat;

import 'widgets/deferred_widget.dart';

final List<NavigationPaneItem> originalItems = [
  // PaneItem(
  //   icon: const Icon(FluentIcons.process),
  //   title: const Text('Despachar'),
  //   body: const DespachoEditPage(),
  // ),

  PaneItemHeader(header: const Text('Ventas')),
  PaneItem(
    icon: const Icon(FluentIcons.assessment_group),
    title: const Text('Ordenes'),
    body: DeferredWidget(
      ventas.loadLibrary,
      () => ventas.SaleOderPage(),
    ),
  ),
  // PaneItem(
  //   icon: const Icon(FluentIcons.people),
  //   title: const Text('Clientes'),
  //   body: DeferredWidget(
  //     ventas.loadLibrary,
  //     () => ventas.ClientPage(),
  //   ),
  // ),
  // PaneItemHeader(header: const Text('Inventarios')),
  PaneItem(
    icon: const Icon(FluentIcons.change_entitlements),
    title: const Text('Despachos'),
    body: DeferredWidget(
      inventarios.loadLibrary,
      () => inventarios.OrdenDespachoPage(),
    ),
  ),
  PaneItemHeader(header: const Text('Sistema')),

  PaneItem(
    icon: const Icon(FluentIcons.info),
    title: const Text('Informacion'),
    body: const InicioPage(),
  ),
  // PaneItemHeader(header: const Text('Servicio Tecnico')),
  // PaneItem(
  //   icon: const Icon(FluentIcons.navigation_flipper),
  //   title: const Text('Equipos'),
  //   body: DeferredWidget(
  //     sat.loadLibrary,
  //     () => sat.EquiposPage(),
  //   ),
  // ),
  // PaneItem(
  //   icon: const Icon(FluentIcons.table_header_row),
  //   title: const Text('Clientes'),
  //   body: DeferredWidget(
  //     ventas.loadLibrary,
  //     () => ventas.ClientPage(),
  //   ),
  // ),
  // PaneItem(
  //   icon: const Icon(FluentIcons.bulleted_tree_list),
  //   title: const Text('Ordenes'),
  //   body: DeferredWidget(
  //     inventarios.loadLibrary,
  //     () => sat.OrdenesSatPage(),
  //   ),
  // ),
];
final List<NavigationPaneItem> footerItems = [
  PaneItemSeparator(),
  // PaneItem(
  //   icon: const Icon(FluentIcons.settings),
  //   title: const Text('Preferencias'),
  //   body: Settings(),
  // ),
  _LinkPaneItemAction(
    icon: const Icon(FluentIcons.open_source),
    title: const Text('GPSTech'),
    link: 'https://galapagos.tech',
    body: const SizedBox.shrink(),
  ),
];

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required super.icon,
    required this.link,
    required super.body,
    super.title,
  });

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        itemIndex: itemIndex,
        autofocus: autofocus,
      ),
    );
  }
}
