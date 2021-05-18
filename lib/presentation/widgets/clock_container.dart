import 'package:flutter/material.dart';
import 'package:flutter_worldtime_clock/res/constants.dart';

class ClockContainer extends StatelessWidget {
  final Widget child;

  const ClockContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Container( // Outer circle
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              color: AppColors.darkClockBg,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.0,
                  spreadRadius: 10.0,
                  color: AppColors.clockShadow
                )
              ]
            ),
          ),
        ),
        Center(
          child: this.child,
        ),
        Center(  // Center pin
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

}