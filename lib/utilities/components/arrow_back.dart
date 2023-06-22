import 'package:beta_doctor/handlers/icon_handler.dart';
import 'package:beta_doctor/handlers/localization_handler.dart';
import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key, this.reverse = false, this.color});
  final bool reverse;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Navigator.of(context).pop,
      child: currentLang() == "en"
          ? drawSvgIcon(
              reverse ? "arrow_right" : "arrow_left",
              iconColor: color ?? Colors.black,
            )
          : drawSvgIcon(
              reverse ? "arrow_left" : "arrow_right",
              iconColor: color ?? Colors.black,
            ),
    );
  }
}
