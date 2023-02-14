import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/widgets/button_change_theme.dart';

import '../core/theme/controllers/settings.dart';
import '../widgets/app_logo_text.dart';
import '../widgets/page.dart';
import '../widgets/session_item.dart';
import 'login/dio_login_provider.dart';
import 'login/models/session_model.dart';

class InicioPage extends ConsumerStatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  ConsumerState<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends ConsumerState<InicioPage> with PageMixin {
  bool selected = true;
  // String? _serverUserProvider;
  // String? _serverPasswordProvider;
  // String? _serverUrlProvider;
  // String? _serverDBProvider;

  void leerDBValues() {
    // _serverUserProvider = ref.watch(Settings.serverUserProvider);
    // _serverPasswordProvider = ref.watch(Settings.serverPasswordProvider);
    // _serverUrlProvider = ref.watch(Settings.serverUrlProvider);
    // _serverDBProvider = ref.watch(Settings.serverDBProvider);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    return ScaffoldPage.scrollable(
      // header: const PageHeader(
      //   title: Text('Inicio'),
      // ),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 490),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.le,
              children: [
                const AppLogo(
                  constraints: BoxConstraints(maxHeight: 80),
                ),
                const AppLogoText(
                  constraints: BoxConstraints(maxHeight: 20),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SessionItemSimple(
                        icon: FluentIcons.home_verify,
                        title: ref.watch(sessionProvider).empresa.toString(),
                      ),
                      SessionItem(
                        icon: FluentIcons.promoted_database,
                        title: ref.watch(Settings.serverUrlProvider),
                        subtitle: ref.watch(Settings.serverDBProvider),
                      ),
                      SessionItem(
                        icon: FluentIcons.user_followed,
                        title: ref.watch(sessionProvider).name.toString(),
                        subtitle: ref.watch(sessionProvider).uid.toString() +
                            ' ' +
                            ref.watch(sessionProvider).email.toString(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextBox(
                        readOnly: true,
                        initialValue: ref.watch(Settings.sessionIdProvider),
                        autofocus: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SizedBox(
                          //   width: 150,
                          //   child: TextBox(
                          //     initialValue: 'VENTA66870',
                          //     autofocus: false,
                          //   ),
                          // ),
                          // Flexible(
                          //   flex: 2,
                          //   child: FilledButton(
                          //     child: const Text('Editar Venta'),
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           FluentPageRoute(
                          //               builder: (context) =>
                          //                   DespachoEditPage()));
                          //     },
                          //   ),
                          // ),
                          Flexible(
                            flex: 2,
                            child: ButtonChangeTheme(),
                          ),

                          Flexible(
                            child: FilledButton(
                              child: const Text('Cerrar Sesión'),
                              onPressed: () {
                                ref.read(loginLoadingProvider.notifier).state =
                                    false;
                                ref
                                    .read(Settings.displayModeProvider.notifier)
                                    .set(PaneDisplayMode.minimal);
                                ref
                                    .read(Settings.sessionIdProvider.notifier)
                                    .state = '';
                                ref.read(sessionProvider.notifier).state =
                                    SessionValues.fromJson({});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
