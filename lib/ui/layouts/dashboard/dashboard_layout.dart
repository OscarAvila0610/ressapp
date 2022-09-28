import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/providers.dart';

import '../../shared/navbar.dart';
import '../../shared/sidebar.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    Provider.of<ModulesProvider>(context, listen: false).getModules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final modulos = Provider.of<ModulesProvider>(context).modulos;
    return Scaffold(
        backgroundColor: const Color(0xffEDF1F2),
        body: Stack(
          children: [
            Row(
              children: [
                if (size.width >= 700) Sidebar(modulos: modulos),
                Expanded(
                  child: Column(
                    children: [
                      const Navbar(),
                      Expanded(
                        child: widget.child,
                      )
                    ],
                  ),
                )
              ],
            ),
            if (size.width < 700)
              AnimatedBuilder(
                  animation: SideMenuProvider.menuController,
                  builder: (_, __) => Stack(
                        children: [
                          if (SideMenuProvider.isOpen)
                            Opacity(
                              opacity: SideMenuProvider.opacity.value,
                              child: GestureDetector(
                                onTap: () => SideMenuProvider.closeMenu(),
                                child: Container(
                                  width: size.width,
                                  height: size.height,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          Transform.translate(
                            offset: Offset(SideMenuProvider.movement.value, 0),
                            child: Sidebar(modulos: modulos),
                          )
                        ],
                      ))
          ],
        ));
  }
}
