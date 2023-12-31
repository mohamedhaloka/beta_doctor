import 'package:flutter/material.dart';

import '../theme/media.dart';
import '../theme/text_styles.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
        this.height,
        this.width,
        this.borderColor,
        this.radius,
        this.text,
        this.buttonColor,
        this.textColor,
        this.loading = false,
        this.onTap,
        this.icon});

  final double? height;
  final double? width;
  final double? radius;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? icon;
  final Function()? onTap;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      borderRadius: BorderRadius.circular(radius ?? 8),
      child: Container(
        width: width ?? MediaHelper.width,
        height: height ?? 56,
        decoration: BoxDecoration(
          color: loading
              ? Colors.grey[300]
              : buttonColor ??
              Theme.of(context).colorScheme.primary.withOpacity(.8),
          borderRadius: BorderRadius.circular(radius ?? 8),
          border:
          Border.all(width: 1, color: borderColor ?? Colors.transparent),
        ),
        child: loading
            ? Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? "Click here",
              style: AppTextStyles.w700.copyWith(
                  fontSize: 14, color: textColor ?? Colors.white),
            ),
            if (icon != null) const SizedBox(width: 8),
            if (icon != null) icon!,
          ],
        ),
      ),
    );
  }
}
