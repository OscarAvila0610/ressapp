import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/sidemenu_provider.dart';

import 'package:ress_app/ui/views/pagina_no_encontrada.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('/404');
    return const PaginaNoEncontrada();
  });
}
