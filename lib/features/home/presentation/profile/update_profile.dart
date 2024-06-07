import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melbook/features/auth/domain/repositories/auth_repository.dart';
import 'package:melbook/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController surnameCtrl = TextEditingController();

  final TextEditingController phoneNumberCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  final TextEditingController confirmPasswordCtrl = TextEditingController();

  @override
  void initState() {
    context.read<AuthBloc>().stream.listen((event) {
      if (event.message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: Stack(
          children: [
            const CustomAppBar(
              displayText: "Profile",
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 20),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  buildTextFieldHeaderText("Foydalanuvchi nomi"),
                  const SizedBox(height: 12),
                  AuthTextField(
                    style: const TextStyle(fontSize: 18),
                    hinText: state.user?.userName,
                    textInputAction: TextInputAction.next,
                    controller: usernameCtrl,
                  ),
                  const SizedBox(height: 20),
                  buildTextFieldHeaderText("Ism"),
                  const SizedBox(height: 12),
                  AuthTextField(
                    style: const TextStyle(fontSize: 18),
                    controller: nameCtrl,
                    hinText: state.user?.name,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  buildTextFieldHeaderText("Familiya"),
                  const SizedBox(height: 12),
                  AuthTextField(
                    style: const TextStyle(fontSize: 18),
                    controller: surnameCtrl,
                    hinText: state.user?.surname,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  buildTextFieldHeaderText("Telefon raqam"),
                  const SizedBox(height: 12),
                  AuthTextField(
                    style: const TextStyle(fontSize: 18),
                    hinText: "\t${state.user?.phoneNumber}",
                    controller: phoneNumberCtrl,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        "assets/icons/ic_phone.svg",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildTextFieldHeaderText("Parol"),
                  const SizedBox(height: 12),
                  AuthTextField(
                    style: const TextStyle(fontSize: 18),
                    hinText: "* * * * * * *",
                    controller: passwordCtrl,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  buildTextFieldHeaderText("Parolni takrorlang"),
                  const SizedBox(height: 12),
                  AuthTextField(
                    style: const TextStyle(fontSize: 18),
                    hinText: "* * * * * * *",
                    controller: confirmPasswordCtrl,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: PrimaryYellowElevatedButton(
                      // width: w * 0.9,
                      // height: h * 0.045,
                      displayText: "Saqlash",
                      onPressed: () {
                        if (confirmPasswordCtrl.text == passwordCtrl.text) {
                          context.read<AuthRepository>().editData(
                                username: usernameCtrl.text,
                                name: nameCtrl.text,
                                phoneNumber: phoneNumberCtrl.text,
                                password: passwordCtrl.text,
                                surname: surnameCtrl.text,
                              );
                        }
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
