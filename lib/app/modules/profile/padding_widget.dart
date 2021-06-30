import 'package:flutter/material.dart';

class PaddingWidget extends StatelessWidget {

  Widget child;
  PaddingWidget({required this.child});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.only(left: 16, top: 16, right: 16),
    child: child,
  );
}
