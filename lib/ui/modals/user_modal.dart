import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ress_app/models/exporter.dart';
import 'package:ress_app/models/role.dart';
import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/providers/providers.dart';
import 'package:ress_app/providers/register_form_provider.dart';

import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/inputs/custom_inputs.dart';
import 'package:ress_app/ui/labels/custom_labels.dart';

class UserModal extends StatefulWidget {
  const UserModal({Key? key, required this.exportadores, required this.roles})
      : super(key: key);

  final List<Exportadore> exportadores;
  final List<Role> roles;

  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  String rol = '';
  String exportador = '';

  @override
  void initState() {
    super.initState();
    rol = 'USER_ROLE';
    exportador = '62cd6c2bdaff5a21cc6158ac';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(
      context,
    );
    return ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: Builder(
          builder: (context) {
            final registerFormProvider =
                Provider.of<RegisterFormProvider>(context, listen: false);
            return Container(
              padding: const EdgeInsets.all(20),
              height: 600,
              width: 300, //Expanded
              decoration: buildBoxDecoration(),
              child: Form(
                key: registerFormProvider.formKey,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nuevo Usuario',
                          style: CustomLabels.h1.copyWith(color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El nombre es obligatorio';
                        }
                        return null;
                      },
                      onChanged: (value) => registerFormProvider.name = value,
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Nombre del Usuario',
                          label: 'Nombre',
                          icon: Icons.people_alt_outlined),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: '',
                      onChanged: (value) => registerFormProvider.email = value,
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return 'Email no valido ejemplo@email.com';
                        }
                        return null;
                      },
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Correo del Usuario',
                          label: 'Correo',
                          icon: Icons.airplanemode_active),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      child: DropdownButtonFormField(
                        decoration: CustomInputs.loginInputDecoration(
                            label: 'Exportadores',
                            hint: '',
                            icon: Icons.explore_outlined),
                        dropdownColor: const Color(0xff0F2039),
                        value: exportador,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String? value) {
                          setState(() {
                            exportador = value!;
                          });
                        },
                        items: widget.exportadores
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                              value: value.id, child: Text(value.nombre));
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      child: DropdownButtonFormField(
                        decoration: CustomInputs.loginInputDecoration(
                            label: 'Roles',
                            hint: '',
                            icon: Icons.explore_outlined),
                        dropdownColor: const Color(0xff0F2039),
                        value: rol,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String? value) {
                          setState(() {
                            rol = value!;
                          });
                        },
                        items:
                            widget.roles.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                              value: value.rol,
                              child: (value.rol == 'ADMIN_ROLE')
                                  ? const Text('Administrador')
                                  : (value.rol == 'USER_ROLE')
                                      ? const Text('Usuario')
                                      : const Text('Analista'));
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      child: CustomOutlinedButton(
                        onPressed: () async {
                          final validForm = registerFormProvider.validateForm();
                          if (!validForm) return;
                          try {
                            await userProvider.newUser(
                                registerFormProvider.email,
                                registerFormProvider.name,
                                rol,
                                exportador);
                            NotificationsService.showSnackbar(
                                'Usuario creado exitosamente');
                            Navigator.of(context).pop();
                          } catch (e) {
                            Navigator.of(context).pop();
                            NotificationsService.showSnackbarError(
                                'No se pudo guardar el Usuario');
                          }
                        },
                        text: 'Guardar',
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092042)]),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
