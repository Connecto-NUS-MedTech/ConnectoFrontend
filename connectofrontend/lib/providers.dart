import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:provider/provider.dart';

/// https://medium.com/@patthipati/code-organization-with-provider-state-management-for-flutter-ae2a77b63718
class Providers {
  Providers._();
  static final providers = [
    ChangeNotifierProvider<HomeSystemState>(
      create: (_) => HomeSystemState(),
    ),
  ].toList();
}
