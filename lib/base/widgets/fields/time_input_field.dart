import 'package:beta_doctor/handlers/icon_handler.dart';
import 'package:beta_doctor/routers/navigator.dart';
import 'package:beta_doctor/utilities/components/custom_btn.dart';
import 'package:beta_doctor/utilities/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeInputField extends StatefulWidget {
  const TimeInputField({
    super.key,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.withBottomPadding = true,
    this.hasError = false,
    this.initialValue,
  });
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool hasError;
  final Function(String)? onChange;
  final bool withBottomPadding;
  final String? initialValue;

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) Text(widget.labelText ?? ""),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => showDatePicker(
            onChange: (value) {
              setState(() {
                this.value = value;
                widget.onChange?.call(value);
              });
            },
          ),
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: _mapBorder(borderColor: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? widget.hintText ?? "",
                    style: AppTextStyles.w300.copyWith(
                        color:
                            value == null ? Theme.of(context).hintColor : null),
                  ),
                ),
                drawSvgIcon("calendar",
                    iconColor: Theme.of(context).iconTheme.color),
              ],
            ),
          ),
        ),
        if (widget.hasError)
          const Text("Error", style: TextStyle(color: Colors.red)),
        if (widget.withBottomPadding) const SizedBox(height: 16),
      ],
    );
  }

  Border _mapBorder({required Color borderColor}) {
    return Border.all(
      width: 1,
      color: borderColor,
    );
  }
}

//===============================================================

showDatePicker({required Function(String) onChange}) {
  DateTime now = DateTime.now();
  String time = "${now.hour}:${now.minute}";
  return showModalBottomSheet(
    context: CustomNavigator.navigatorState.currentContext!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.primary),
              ),
              child: Center(
                child: Icon(Icons.close,
                    color: Theme.of(context).colorScheme.primary, size: 16),
              ),
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(20),
            child: CupertinoDatePicker(
              minimumDate: DateTime(1900),
              maximumDate: DateTime.now().add(const Duration(days: 1000)),
              initialDateTime: DateTime.now(),
              use24hFormat: false,
              mode: CupertinoDatePickerMode.time,
              dateOrder: DatePickerDateOrder.ymd,
              onDateTimeChanged: (value) {
                time = "${value.hour}:${value.minute}";
                onChange("${value.hour}:${value.minute}");
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomBtn(
            text: "Pick",
            height: 56,
            onTap: () {
              onChange(time);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}
