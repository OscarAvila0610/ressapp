import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_validator/email_validator.dart';
import 'package:ress_app/providers/auth_provider.dart';
import 'package:ress_app/providers/providers.dart';

// import 'package:ress_app/router/router.dart';

import '../../providers/login_form_provider.dart';
import '../buttons/custom_outlined_button.dart';
import '../inputs/custom_inputs.dart';
// import 'package:ress_app/ui/buttons/link_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(
          builder: (context) {
            final loginFormProvider =
                Provider.of<LoginFormProvider>(context, listen: false);
            return Container(
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 370),
                    child: Form(
                      key: loginFormProvider.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onFieldSubmitted: (_) =>
                                onFormSubmit(loginFormProvider, authProvider),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su correo';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'Correo no valido';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                loginFormProvider.email = value,
                            style: const TextStyle(color: Colors.white),
                            decoration: CustomInputs.loginInputDecoration(
                                hint: 'Ingrese su correo',
                                label: 'Correo',
                                icon: Icons.email_outlined),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onFieldSubmitted: (_) =>
                                onFormSubmit(loginFormProvider, authProvider),
                            onChanged: (value) =>
                                loginFormProvider.password = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su contrase??a';
                              }
                              if (value.length < 8) {
                                return 'La contrase??a debe de ser de 8 caracteres';
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: CustomInputs.loginInputDecoration(
                                hint: '***********',
                                label: 'Contrase??a',
                                icon: Icons.lock_outline),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomOutlinedButton(
                            onPressed: () =>
                                onFormSubmit(loginFormProvider, authProvider),
                            text: 'Ingresar',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }

  void onFormSubmit(
      LoginFormProvider loginFormProvider, AuthProvider authProvider) {
    final isValid = loginFormProvider.validateForm();
    if (isValid) {
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
    }
  }
}
