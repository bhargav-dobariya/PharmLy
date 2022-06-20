import 'package:flutter/material.dart';

class CommonSizedBox extends StatelessWidget {
  const CommonSizedBox({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
