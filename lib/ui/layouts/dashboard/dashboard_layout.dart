import 'package:flutter/material.dart';
import 'package:ress_app/providers/sidemenu_provider.dart';

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
    super.initState();
    SideMenuProvider.menuController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xffEDF1F2),
        body: Stack(
          children: [
            Row(
              children: [
                if (size.width >= 700) const Sidebar(),
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
                        children:  [
                          if(SideMenuProvider.isOpen)
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
                            child: const Sidebar(),
                          )
                        ],
                      ))
          ],
        ));
  }
}