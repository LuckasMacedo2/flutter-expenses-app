import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  
  final String label;
  final void Function() onPressed;

  AdaptativeButton({
    required this.label,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
      CupertinoButton(child: Text(label)
      , onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        horizontal: 20
      ),
      color: Theme.of(context).primaryColor,)
      : ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          textStyle: TextStyle(
            color: Theme.of(context).textTheme.button!.color, // Cor do texto do botão
          ),
        ),
      );
  }
}