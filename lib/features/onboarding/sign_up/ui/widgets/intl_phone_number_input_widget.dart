import '../../constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class IntlPhoneNumberInputWidget extends StatelessWidget {
  const IntlPhoneNumberInputWidget({super.key, this.onInputChanged});

  final Function(PhoneNumber phoneNumber)? onInputChanged;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      onInputChanged: (value) => onInputChanged?.call(value),
      countries: const ['IN'],
      initialValue: PhoneNumber(
        isoCode: 'IN',
        dialCode: '+91',
      ),
      maxLength: 11,
      ignoreBlank: true,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        showFlags: false,
        setSelectorButtonAsPrefixIcon: true,
      ),
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: false),
      spaceBetweenSelectorAndTextField: 0.0,
      selectorTextStyle: StyleConstants.textStyle2.copyWith(
        color: const Color(0xff313030),
      ),
      textStyle: StyleConstants.textStyle2.copyWith(
        color: const Color(0xff313030),
      ),
      inputBorder: InputBorder.none,
      searchBoxDecoration: InputDecoration(
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 12),
        hintText: 'Search by country name',
        filled: true,
        fillColor: const Color(0xffF2F4F9),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink.shade50.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink.shade50.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(1.5),
        ),
      ),
      inputDecoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(),
        hintStyle: StyleConstants.textStyle2.copyWith(
          color: const Color(0xff797979),
        ),
        hintText: '00000 00000',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
