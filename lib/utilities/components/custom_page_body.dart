import 'package:beta_doctor/utilities/theme/media.dart';
import 'package:flutter/material.dart';

class CustomPageBody extends StatelessWidget {
  const CustomPageBody(
      {super.key, required this.body, this.appBar, this.floatingActionButton});
  final Widget body;
  final FloatingActionButton? floatingActionButton;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: body,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
