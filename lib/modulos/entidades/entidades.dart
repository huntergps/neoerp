import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/list_header.dart';
import 'vars/partner_filters.dart';

class ClientPage extends ConsumerStatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ClientPage> createState() => _ClientPagePageState();
}

class _ClientPagePageState extends ConsumerState<ClientPage> with PageMixin {
  @override
  Widget build(BuildContext context) {
    // final theme = FluentTheme.of(context);
    return ScaffoldPage.scrollable(
      header: const ListHeaderPage(
        icon: FluentIcons.people,
        title: 'Clientes',
        filterOptions: clientFilterItems,
      ),
      children: const [
        Card(
          child: Center(
            child: Text(
              'Listado de Clientes.',
            ),
          ),
        ),
      ],
    );
  }
}
