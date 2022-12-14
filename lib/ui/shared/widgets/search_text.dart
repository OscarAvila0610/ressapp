import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
        ],
        onFieldSubmitted: (awb) {
          NavigationService.navigateTo('/dashboard/reservas/awb/$awb');
          awb = '';
        },
        decoration: CustomInputs.searchInputDecoration(
            hint: 'Buscar por # AWB', icon: Icons.search_outlined),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.withOpacity(0.1));
}
