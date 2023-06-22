import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key, required this.name, required this.department})
      : super(key: key);
  final String name, department;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            bottom: -50,
            left: -50,
            child: Transform.rotate(
              angle: 100,
              child: Image.asset(
                'assets/images/splash.png',
                color: Colors.white10,
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            )),
        Positioned(
          top: 80,
          left: 20,
          right: 20,
          bottom: 20,
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  name,
                  style:const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                department,
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
