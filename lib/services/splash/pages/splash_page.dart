import 'dart:async';

import 'package:beta_doctor/utilities/components/custom_page_body.dart';
import 'package:beta_doctor/utilities/theme/media.dart';
import 'package:flutter/material.dart';

import '../../../handlers/shared_handler.dart';
import '../../../routers/navigator.dart';
import '../../../routers/routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> opacityAnimation;

  _setAnimation() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    opacityAnimation = Tween<double>(end: 1, begin: 0).animate(controller);
    controller.forward();
    controller.addListener(() => setState(() {}));
  }

  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        final Map? userData = SharedHandler.instance?.getData(
          key: SharedKeys().user,
          valueType: ValueType.map,
        );

        if ((userData ?? {}).isNotEmpty) {
          CustomNavigator.push(Routes.home);
        } else {
          CustomNavigator.push(Routes.login);
        }
      },
    );
    _setAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageBody(
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: Column(
          children: [
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: opacityAnimation.value,
                child: Center(
                  child: Image.asset(
                    "assets/images/splash.png",
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
