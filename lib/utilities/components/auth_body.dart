import 'package:flutter/material.dart';

import 'custom_page_body.dart';

class AuthBody extends StatelessWidget {
  const AuthBody(this.child, {Key? key, this.showBackBtn = false})
      : super(key: key);
  final Widget child;
  final bool showBackBtn;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPageBody(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.secondary,
            width: size.width,
            height: size.height,
          ),
          Positioned(
            left: 100,
            child: Transform.rotate(
              angle: 20,
              child: Container(
                height: 60,
                width: size.width,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: -39,
            child: Transform.rotate(
              angle: 100,
              child: Container(
                height: 60,
                width: size.width,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            child: child,
          ),
          if (showBackBtn)
            Positioned(
              top: 30,
              right: 20,
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.arrow_back),
              ),
            ),
        ],
      ),
    );
  }
}
