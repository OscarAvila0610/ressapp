import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/providers/sidemenu_provider.dart';
import 'package:ress_app/router/router.dart';
import 'package:ress_app/ui/cards/white_card.dart';


class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width <= 700)
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () => SideMenuProvider.openMenu(),
            ),
          const SizedBox(
            width: 10,
          ),
          if (sideMenuProvider.currentPage == Flurorouter.bookingsRoute ||
              sideMenuProvider.currentPage == Flurorouter.awbRoute)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Container(),
            ),
          const Spacer(),
          if (size.width > 525)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: WhiteCard(
                  child: Text(
                user!.correo,
                style: GoogleFonts.robotoSlab(
                    fontSize: 13, fontWeight: FontWeight.bold),
              )),
            ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
