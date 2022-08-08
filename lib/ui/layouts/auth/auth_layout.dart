import 'package:flutter/material.dart';
import 'package:ress_app/ui/layouts/auth/widgets/background.dart';
import 'package:ress_app/ui/layouts/auth/widgets/custom_title.dart';
import 'package:ress_app/ui/layouts/auth/widgets/links_bar.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          (size.width > 1000)
              ? _DesktopBody(child: child)
              : _MobileBody(child: child),
          //LinksBar
          const LinksBar()
        ],
          ),
      ));
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.93,
      color: Colors.black,
      child: Row(
        children: [
          //Background
          const Background(),

          //Vista
          Container(
              width: 600,
              height: double.infinity,
              color: Colors.black,
              child: Column(
                children: [
                  const CustomTitle(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: child,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          Container(
            width: double.infinity,
            height: 400,
            child: Background()
          )
        ],
      ),
    );
  }
}
