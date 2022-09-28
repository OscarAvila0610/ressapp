import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/providers.dart';

import 'package:ress_app/router/router.dart';

import 'package:ress_app/services/navigation_service.dart';

import 'package:ress_app/ui/shared/widgets/logo.dart';
import 'package:ress_app/ui/shared/widgets/menu_item.dart';
import 'package:ress_app/ui/shared/widgets/text_separator.dart';

import '../../models/http/modules_response.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key, required this.modulos}) : super(key: key);
  final List<Modulo> modulos;

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final titulo = (user!.uid == 'ADMIN_ROLE')
        ? 'Administrador'
        : (user.uid == 'USER_ROLE')
            ? 'Usuario'
            : 'Analista';
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Logo(user: user),
          const SizedBox(
            height: 50,
          ),
          TextSeparator(text: titulo),
          for (var i = 0; i < modulos.length; i++) ...[
            MenuItem(
                isActive: sideMenuProvider.currentPage == modulos[i].ruta,
                text: modulos[i].nombre,
                icon: IconData(int.parse(modulos[i].icono),
                    fontFamily: 'MaterialIcons'),
                onPressed: () => navigateTo(modulos[i].ruta)),
          ],
          MenuItem(
              isActive: sideMenuProvider.currentPage == Flurorouter.userRoute,
              text: 'Perfil',
              icon: Icons.note_add_outlined,
              onPressed: () => navigateTo('/dashboard/users/${user.uid}')),
          const SizedBox(
            height: 30,
          ),
          const TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Salir',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092042)]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
