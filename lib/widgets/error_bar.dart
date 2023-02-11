import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/dio_provider.dart';
import '../modulos/login/dio_login_provider.dart';

class ErrorLogin extends ConsumerWidget {
  const ErrorLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msn = ref.watch(loginErrorMsnProvider);
    return InfoBar(
      title: const Text('Error'),
      content: Text(msn),
      severity: InfoBarSeverity.error,
      isLong: true,
    );
  }
}

class ErrorApi extends ConsumerWidget {
  const ErrorApi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msn = ref.watch(dioErrorMsnProvider);
    return InfoBar(
      title: const Text('Error'),
      content: Text(msn),
      severity: InfoBarSeverity.error,
      isLong: true,
    );
  }
}
