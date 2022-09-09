import 'package:flutter/material.dart';
import 'package:ress_app/services/navigation_service.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';

class SearchText extends StatelessWidget {
  const SearchText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: TextFormField(
        onFieldSubmitted: (awb) =>
            NavigationService.navigateTo('/dashboard/reservas/awb/$awb'),
        decoration: CustomInputs.searchInputDecoration(
            hint: 'Buscar', icon: Icons.search_outlined),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.withOpacity(0.1));
}
