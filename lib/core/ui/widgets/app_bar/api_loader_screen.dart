import 'package:flutter/material.dart';

class ApiLoaderScreen extends StatelessWidget {
  final Color? bgColor;
  const ApiLoaderScreen({Key? key, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgColor ?? Colors.black.withOpacity(0.4),
        child: const Center(
            child: CircularProgressIndicator(color: Color(0xffE72D38))));
  }
}
