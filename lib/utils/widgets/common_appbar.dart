import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  final String appTitle;
  const CommonAppBar({super.key, required this.appTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(appTitle));
  }
}
