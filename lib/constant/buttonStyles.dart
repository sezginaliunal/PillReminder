import 'package:flutter/material.dart';

import 'colors.dart';

class ButtonStyles {
  static ButtonStyle loginResetButton = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.resolveWith((states) => ColorItems.lacivert),
  );
  static ButtonStyle redButton = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.resolveWith((states) => ColorItems.kirmizi),
  );
  static ButtonStyle greenButton = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => ColorItems.yesil));

  static ButtonStyle confirmButton = ButtonStyle(
    shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
    padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(20)),
    backgroundColor:
        MaterialStateProperty.resolveWith((states) => ColorItems.lacivert),
  );
}
