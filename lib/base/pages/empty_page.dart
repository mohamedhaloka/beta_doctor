// ignore_for_file: deprecated_member_use

import 'package:beta_doctor/utilities/components/custom_page_body.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key, this.body});
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return CustomPageBody(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/empty.png",
            fit: BoxFit.contain,
          ),
          body ??
              Text("No data found",
                  style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }
}
