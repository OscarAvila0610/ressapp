import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/auth_provider.dart';

import 'package:ress_app/router/router.dart';

import 'package:ress_app/providers/sidemenu_provider.dart';

import 'package:ress_app/services/navigation_service.dart';

import 'package:ress_app/ui/shared/widgets/logo.dart';
import 'package:ress_app/ui/shared/widgets/menu_item.dart';
import 'package:ress_app/ui/shared/widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    const admin = 'ADMIN_ROLE';
    const usuario = 'USER_ROLE';
    const analist = 'ANALIST_ROLE';
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(
            height: 50,
          ),
          if (user!.rol == admin) ...[
            const TextSeparator(text: 'Administrador'),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
                text: 'Dashboard',
                icon: Icons.compass_calibration_outlined,
                onPressed: () => navigateTo(Flurorouter.dashboardRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.originsRoute,
                text: 'Origenes',
                icon: Icons.flag_outlined,
                onPressed: () => navigateTo(Flurorouter.originsRoute)),
            MenuItem(
                isActive: sideMenuProvider.currentPage ==
                    Flurorouter.destinationsRoute,
                text: 'Destinos',
                icon: Icons.airplane_ticket_outlined,
                onPressed: () => navigateTo(Flurorouter.destinationsRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.containersRoute,
                text: 'Contenedores',
                icon: Icons.add_box_outlined,
                onPressed: () => navigateTo(Flurorouter.containersRoute)),
            MenuItem(
                isActive: sideMenuProvider.currentPage ==
                    Flurorouter.commoditiesRoute,
                text: 'Tipo de Carga',
                icon: Icons.shop_outlined,
                onPressed: () => navigateTo(Flurorouter.commoditiesRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.airlinesRoute,
                text: 'Aerolineas',
                icon: Icons.airplanemode_active_outlined,
                onPressed: () => navigateTo(Flurorouter.airlinesRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.exportersRoute,
                text: 'Exportadores',
                icon: Icons.turned_in_not_outlined,
                onPressed: () => navigateTo(Flurorouter.exportersRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.usersRoute,
                text: 'Usuarios',
                icon: Icons.people_alt_outlined,
                onPressed: () => navigateTo(Flurorouter.usersRoute)),
            const SizedBox(
              height: 30,
            ),
          ],
          if (user.rol == usuario) ...[
            const TextSeparator(text: 'Usuario'),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
                text: 'Dashboard',
                icon: Icons.compass_calibration_outlined,
                onPressed: () => navigateTo(Flurorouter.dashboardRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.iconsRoute,
                text: 'Iconos',
                icon: Icons.list_alt_outlined,
                onPressed: () => navigateTo(Flurorouter.iconsRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.bookingsRoute,
                text: 'Reservas',
                icon: Icons.mark_email_read_outlined,
                onPressed: () => navigateTo(Flurorouter.bookingsRoute)),
            MenuItem(
                isActive: sideMenuProvider.currentPage == Flurorouter.userRoute,
                text: 'Perfil',
                icon: Icons.note_add_outlined,
                onPressed: () => navigateTo('/dashboard/users/${user.uid}')),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.calculatorRoute,
                text: 'Calculadora',
                icon: Icons.calculate_outlined,
                onPressed: () => navigateTo(Flurorouter.calculatorRoute)),
            const SizedBox(
              height: 30,
            ),
          ],
          if (user.rol == analist) ...[
            const TextSeparator(text: 'Analista'),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
                text: 'Dashboard',
                icon: Icons.compass_calibration_outlined,
                onPressed: () => navigateTo(Flurorouter.dashboardRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.iconsRoute,
                text: 'Iconos',
                icon: Icons.list_alt_outlined,
                onPressed: () => navigateTo(Flurorouter.iconsRoute)),
            MenuItem(
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.bookingsRoute,
                text: 'Reservas',
                icon: Icons.mark_email_read_outlined,
                onPressed: () => navigateTo(Flurorouter.bookingsRoute)),
            MenuItem(
                isActive: sideMenuProvider.currentPage == Flurorouter.userRoute,
                text: 'Perfil',
                icon: Icons.note_add_outlined,
                onPressed: () => navigateTo('/dashboard/users/${user.uid}')),
            const SizedBox(
              height: 30,
            ),
          ],
          const TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Logout',
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
