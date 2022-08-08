import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/providers/register_form_provider.dart';

import 'package:ress_app/router/router.dart';

import 'package:email_validator/email_validator.dart';

import '../inputs/custom_inputs.dart';
import '../buttons/custom_outlined_button.dart';
import 'package:ress_app/ui/buttons/link_text.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: Builder(
          builder: (context) {
            final registerFormProvider =
                Provider.of<RegisterFormProvider>(context, listen: false);
            return Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 370),
                    child: Form(
                      key: registerFormProvider.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) =>
                                registerFormProvider.name = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El nombre es obligatorio';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: CustomInputs.loginInputDecoration(
                                hint: 'Ingrese su nombre',
                                label: 'Nombre',
                                icon: Icons.supervised_user_circle_sharp),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                registerFormProvider.email = value,
                            validator: (value) {
                              if (!EmailValidator.validate(value ?? '')) {
                                return 'Email no valido';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: CustomInputs.loginInputDecoration(
                                hint: 'Ingrese su correo',
                                label: 'Email',
                                icon: Icons.email_outlined),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                registerFormProvider.password = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su contraseña';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe de ser de 6 caracteres';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: CustomInputs.loginInputDecoration(
                                hint: '***********',
                                label: 'Contraseña',
                                icon: Icons.lock_outline),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomOutlinedButton(
                            onPressed: () {
                              final validForm =
                                  registerFormProvider.validateForm();
                              if (!validForm) return;
                              final authProvider = Provider.of<AuthProvider>(
                                  context,
                                  listen: false);
                              authProvider.register(
                                  registerFormProvider.email,
                                  registerFormProvider.password,
                                  registerFormProvider.name,
                                  'ANALIST_ROLE',
                                  '62cd6c2bdaff5a21cc6158ac');
                            },
                            text: 'Crear cuenta',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LinkText(
                            text: 'Ir al Login',
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Flurorouter.loginRoute);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
