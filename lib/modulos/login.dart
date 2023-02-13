import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flextras/flextras.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo/widgets/error_bar.dart';
import 'package:neo/widgets/plataforma.dart';

import '../core/theme/controllers/settings.dart';
import '../widgets/app_logo_text.dart';
import '../widgets/page.dart';
import 'login/dio_login_provider.dart';
import 'login/models/session_model.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with PageMixin {
  bool modificarServerData = false;
  // String? comboboxValue;
  late TextEditingController _emailController;
  late TextEditingController _passController;

  late TextEditingController _serverController;
  late TextEditingController _dataBaseController;

  bool get enableSubmit {
    bool emailAndPassAreValid = _serverController.text.length > 20 &&
        _dataBaseController.text.length > 5 &&
        _emailController.text.length > 3 &&
        _passController.text.length >= 2;
    return emailAndPassAreValid;
  }

  // bool get modificarServerData {
  //   bool emailAndPassAreValid = _serverController.text.length < 20 ||
  //       _dataBaseController.text.length < 5;
  //   return emailAndPassAreValid;
  // }

  @override
  void initState() {
    super.initState();
    // leerDBValues();
    _emailController =
        TextEditingController(text: ref.read(Settings.serverUserProvider));
    _passController =
        TextEditingController(text: ref.read(Settings.serverPasswordProvider));
    _serverController =
        TextEditingController(text: ref.read(Settings.serverUrlProvider));
    _dataBaseController =
        TextEditingController(text: ref.read(Settings.serverDBProvider));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _serverController.dispose();
    _dataBaseController.dispose();
    super.dispose();
  }

  void leerDBValues() {
    _emailController.text = ref.read(Settings.serverUserProvider);
    _passController.text = ref.read(Settings.serverPasswordProvider);
    _serverController.text = ref.read(Settings.serverUrlProvider);
    _dataBaseController.text = ref.read(Settings.serverDBProvider);
    ref.read(loginErrorMsnProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);

    return ScaffoldPage.withPadding(
        // header: const PageHeader(
        //   title: Text('Ingresar'),
        // ),
        content: AutofillGroup(
          child: Form(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 400, maxHeight: 510),
                child: ExpandedScrollingColumn(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        children: [
                          TextBox(
                            enabled: modificarServerData,
                            header: 'Servidor:',
                            expands: false,
                            onSubmitted: (_) {},
                            controller: _serverController,
                            autofocus: true,
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextBox(
                            enabled: modificarServerData,
                            header: 'Base de Datos:',
                            // placeholder: 'Base de Datos',
                            expands: false,
                            onSubmitted: (_) {},
                            controller: _dataBaseController,
                            autofocus: true,
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextBox(
                            header: 'Usuario:',
                            // placeholder: 'Usuario',
                            expands: false,
                            onSubmitted: (_) {},
                            controller: _emailController,
                            autofocus: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextBox(
                            header: 'Clave:',
                            // placeholder: 'Clave',
                            expands: false,
                            onSubmitted: (_) {},
                            controller: _passController,
                            autofocus: true,
                            obscureText: true,
                            onChanged: (_) => setState(() {}),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (ref.watch(loginLoadingProvider)) ...[
                      const ProgressBar(),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            child: const Text('Borrar'),
                            focusable: false,
                            onPressed: () => leerDBValues(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          FilledButton(
                            child: const Text('Ingresar'),
                            onPressed: enableSubmit
                                ? () async {
                                    ref
                                        .read(loginLoadingProvider.notifier)
                                        .state = true;

                                    ref
                                        .read(loginErrorMsnProvider.notifier)
                                        .state = '';

                                    ref
                                        .read(Settings
                                            .serverUserProvider.notifier)
                                        .set(_emailController.text);
                                    ref
                                        .read(Settings
                                            .serverPasswordProvider.notifier)
                                        .set(_passController.text);

                                    ref
                                        .read(
                                            Settings.serverUrlProvider.notifier)
                                        .set(_serverController.text);

                                    ref
                                        .read(
                                            Settings.serverDBProvider.notifier)
                                        .set(_dataBaseController.text);
                                    final dioClient =
                                        ref.watch(dioLoginProvider);
                                    final dbConfig = {
                                      'username': ref
                                          .watch(Settings.serverUserProvider),
                                      'password': ref.watch(
                                          Settings.serverPasswordProvider),
                                      'db': ref.watch(Settings.serverDBProvider)
                                    };
                                    // final mlogin = login(dioClient, dbConfig);
                                    const String getTokenUrl =
                                        '/api/auth/login';
                                    final url =
                                        dioClient.options.baseUrl + getTokenUrl;
                                    var errorMsn = "";
                                    try {
                                      final result = await dioClient.post(url,
                                          data: jsonEncode(dbConfig));

                                      if (result.statusCode == 200) {
                                        final res = SessionValues.fromJson(
                                            result.data!);
                                        if (PlatformInfo.isAppOS()) {
                                          ref
                                              .read(
                                                  displayModeProvider.notifier)
                                              .state = PaneDisplayMode.minimal;
                                        } else {
                                          ref
                                              .read(
                                                  displayModeProvider.notifier)
                                              .state = PaneDisplayMode.compact;
                                        }

                                        ref
                                            .read(Settings
                                                .sessionIdProvider.notifier)
                                            .state = res.token!;
                                        ref
                                            .read(sessionProvider.notifier)
                                            .state = res;
                                      }
                                    } on DioError catch (e) {
                                      if (e.response != null) {
                                        final mdata = e.response!.data;
                                        errorMsn = " ${mdata['error_descrip']}";
                                      } else {
                                        errorMsn = " ${e.message}";
                                      }
                                      ref
                                          .read(loginErrorMsnProvider.notifier)
                                          .state = errorMsn;
                                      ref
                                          .read(displayModeProvider.notifier)
                                          .state = PaneDisplayMode.minimal;
                                      ref
                                          .read(Settings
                                              .sessionIdProvider.notifier)
                                          .state = '';
                                      ref
                                          .read(loginLoadingProvider.notifier)
                                          .state = false;
                                    }
                                  }
                                : null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      ToggleSwitch(
                        checked: modificarServerData,
                        onChanged: (v) =>
                            setState(() => modificarServerData = v),
                        content: Text(
                          modificarServerData
                              ? 'Deshabilitar la edicion de datos de Conexion'
                              : 'Habilitar la edicion de datos de Conexion',
                          style: theme.typography.caption?.copyWith(
                            fontWeight: FontWeight.w200,
                            color:
                                ref.watch(Settings.accentColorProvider).darkest,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        // const SizedBox(height: 22.0),

        bottomBar: ref.watch(loginErrorMsnProvider).isNotEmpty
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: ErrorLogin(),
              )
            : Container());
  }
}
