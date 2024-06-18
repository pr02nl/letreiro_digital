import 'package:flutter_modular/flutter_modular.dart';

import 'home/home_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {}
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const HomePage(),
    );
  }
}
