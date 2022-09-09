import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/providers/sidemenu_provider.dart';
import 'package:ress_app/router/router.dart';
import 'package:ress_app/ui/cards/white_card.dart';

import 'package:ress_app/ui/shared/widgets/search_text.dart';

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
            width: 5,
          ),
          if (sideMenuProvider.currentPage == Flurorouter.bookingsRoute ||
              sideMenuProvider.currentPage == Flurorouter.awbRoute)
            if (size.width > 390)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: const SearchText(),
              ),

          const Spacer(),
          WhiteCard(
              child: Text(
            user!.correo,
            style:
                GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold),
          )),
          // const NotificationIndicator(),
          // const SizedBox(width: 10,),
          // const NavbarAvatar(),
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
