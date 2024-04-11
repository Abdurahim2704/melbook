import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  String formatCardNumber(String input) {
    String cleanedInput = input.replaceAll(' ', '');

    /// #Regex to add spaces to every 4 characters
    String formattedInput = cleanedInput.replaceAllMapped(
      RegExp(r'.{4}'),
      (match) => '${match.group(0)} ',
    );

    return formattedInput.trim();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatCardNumber(newValue.text);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CardDateFormatter extends TextInputFormatter {
  String formatCardDate(String input) {
    String cleanedInput = input.replaceAll(RegExp(r'\D'), '');

    /// Regex to add '/' after the first two characters
    String formattedInput = cleanedInput.replaceAllMapped(
      RegExp(r'^(\d{2})(\d{0,2})'),
      (match) {
        if (match.group(2)!.isNotEmpty) {
          return '${match.group(1)}/${match.group(2)}';
        } else {
          return '${match.group(1)}';
        }
      },
    );

    return formattedInput.trim();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = formatCardDate(newValue.text);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
