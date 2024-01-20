import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String) onSubmit;

  AdaptativeTextField({
    required this.label,
    required this.controller,
    required this.onSubmit,
    this.keyboardType =  TextInputType.text,
    });



  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CupertinoTextField(
          controller: controller,
          keyboardType: keyboardType,
          onSubmitted: (_) => onSubmit,
          placeholder: label,
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 12
          ),
        ),
      )
      :
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        onSubmitted: (_) => onSubmit,
        decoration: InputDecoration(
          labelText: label
        )
      );
  }
}