import 'package:flutter/material.dart';

class ClickWidget extends StatelessWidget {
  const ClickWidget({Key? key, required this.child, this.onTap})
      : super(key: key);
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
