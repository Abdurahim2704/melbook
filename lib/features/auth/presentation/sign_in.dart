import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:melbook/features/home/presentation/main_screen.dart';
import 'package:melbook/shared/widgets/app_bar.dart';
import 'package:melbook/shared/widgets/auth_textfield.dart';
import 'package:melbook/shared/widgets/auth_textfield_header.dart';
import 'package:melbook/shared/widgets/primary_yellow_elevated_button.dart';

import 'bloc/auth_bloc/auth_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final usernameCtrl = TextEditingController();

  final passwordCtrl = TextEditingController();
  var maskTextInputFormatter = MaskTextInputFormatter(
    mask: ' ## ###-##-##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().stream.listen((event) {
      if (event.message != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(event.message!)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: CustomAppBar(displayText: "Tizimga kirish"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            /// #Header Logo
            Center(
              child: Image(
                image: const AssetImage("assets/images/img_logo_melbook.png"),
                width: w * 0.5,
                height: h * 0.05,
              ),
            ),
            const SizedBox(height: 40),

            /// #TextField Header
            buildTextFieldHeaderText("Foydalanuvchi nomi"),
            const SizedBox(height: 12),

            /// #TextField Username
            AuthTextField(
              style: const TextStyle(fontSize: 18, color: Color(0xFF201A21)),
              controller: usernameCtrl,
              hinText: "Foydalanuvchi nomini kiriting",
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),

            /// #TextField Header
            buildTextFieldHeaderText("Parol"),

            const SizedBox(height: 12),

            /// #TextField Password
            AuthTextField(
              style: const TextStyle(fontSize: 18, color: Color(0xFF201A21)),
              hinText: "12345mkl",
              controller: passwordCtrl,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),

      /// Navigator Button
      bottomNavigationBar: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 40.0, left: 20, right: 20),
            child: PrimaryYellowElevatedButton(
              displayText: "Tizimga kirish",
              onPressed: () {
                context.read<AuthBloc>().add(
                      SignInEvent(
                        password: passwordCtrl.text.trim(),
                        username: usernameCtrl.text.trim(),
                      ),
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
