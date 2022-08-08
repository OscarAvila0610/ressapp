import 'package:flutter/material.dart';
import 'package:ress_app/providers/sidemenu_provider.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('User Layout'),
    );
  }
}
