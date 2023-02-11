import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String appTitle = 'Flex ERP';

final appTitleProvider = StateProvider<String>(
  (ref) => appTitle,
);

// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
