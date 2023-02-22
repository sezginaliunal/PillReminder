import 'package:flutter/material.dart';
import '../constant/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  String title = "Pill Reminder";

  CustomAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorItems.lacivert,
      title: Text(title),
    );
  }
}
