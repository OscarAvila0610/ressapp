import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ress_app/models/user.dart';
import 'package:ress_app/providers/providers.dart';

import 'package:ress_app/services/navigation_service.dart';
import 'package:ress_app/services/notifications_service.dart';

import 'package:ress_app/ui/inputs/custom_inputs.dart';

import '../cards/white_card.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;
  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserbyId(widget.uid).then((userDB) {
      if (userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          user = userDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard/users');
      }
    });
  }

  // @override
  // void dispose() {
  //   user = null;
  //   Provider.of<UserFormProvider>(context, listen: false).user = null;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            if (user == null)
              WhiteCard(
                  child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const CircularProgressIndicator(),
              )),
            if (user != null) const _UserViewBody()
          ],
        ));
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: const {0: FixedColumnWidth(250)},
        children: const [
          TableRow(children: [_UserViewForm()])
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;
    String oldPass = '';
    String newPass = '';
    String confPass = '';
    return WhiteCard(
        title: 'Informacion general',
        child: Form(
          key: userFormProvider.formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: user.nombre,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Nombre del usuario',
                    label: 'Nombre',
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(nombre: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre';
                  }
                  if (value.length < 2) {
                    return 'El nombre debe de ser mayor a 2 letras';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: user.correo,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Correo del usuario',
                    label: 'Correo',
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(correo: value),
                validator: (value) {
                  if (!EmailValidator.validate(value ?? '')) {
                    return 'Email no valido';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) => oldPass = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su contraseña actual';
                  }
                  if (value.length < 8) {
                    return 'La contraseña debe de ser de 8 caracteres';
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: CustomInputs.formInputDecoration(
                    hint: '***********',
                    label: 'Contraseña Actual',
                    icon: Icons.lock_outline),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) => newPass = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nueva contraseña';
                  }
                  if (value.length < 8) {
                    return 'La contraseña debe de ser de al menos 8 caracteres';
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: CustomInputs.formInputDecoration(
                    hint: '***********',
                    label: 'Nueva Contraseña',
                    icon: Icons.lock_outline),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) => confPass = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nueva contraseña para confirmar';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe de ser de 6 caracteres';
                  }
                  if (newPass != confPass) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: CustomInputs.formInputDecoration(
                    hint: '***********',
                    label: 'Confimar Contraseña',
                    icon: Icons.lock_outline),
              ),
              const SizedBox(
                height: 20,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),
                child: ElevatedButton(
                  onPressed: () async {
                    final saved =
                        await userFormProvider.updateUser(oldPass, newPass);
                    if (saved) {
                      NotificationsService.showSnackbar('Usuario Actualizado');
                      Provider.of<UsersProvider>(context, listen: false)
                          .refreshUser(user);
                    } else {
                      NotificationsService.showSnackbarError(
                          'Usuario no Actualizado');
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.save_outlined,
                        size: 20,
                      ),
                      Text(' Guardar')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
