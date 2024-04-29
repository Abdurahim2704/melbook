import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAlertDialog extends StatelessWidget {
  final String displayText;
  final void Function() onPressed;

  const CustomAlertDialog({
    super.key,
    required this.displayText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 14.0),
        child: AlertDialog(
          elevation: 7,
          shadowColor: CupertinoColors.separator,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              const SizedBox(height: 10),
              SvgPicture.asset(
                "assets/icons/ic_dialog_pattern.svg",
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 40),
              Text(
                displayText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF201A21),
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF201A21),
                  fixedSize: const Size(300, 50),
                ),
                onPressed: onPressed,
                child: const Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
