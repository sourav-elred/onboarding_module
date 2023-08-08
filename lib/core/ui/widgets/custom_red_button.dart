import 'package:flutter/material.dart';

class CustomRedButton extends StatelessWidget {
  const CustomRedButton({super.key, this.onTap, required this.labelText});

  final String labelText;
  // final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 335,
        height: 48,
        child: Stack(
          children: [
            Container(
              decoration: ShapeDecoration(
                color: onTap == null
                    ? const Color(0x4CE72D38)
                    : const Color(0xFFE72D38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
            ),
            Center(
              child: Text(
                labelText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Avenir Next LT Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
