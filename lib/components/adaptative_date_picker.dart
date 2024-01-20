import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';
import 'package:intl/intl.dart';


import 'package:flutter/cupertino.dart';

class adaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function (DateTime) onDateChanged;

  const adaptativeDatePicker({required this.selectedDate, required this.onDateChanged});

  _showDatePicker(BuildContext context) {
    // Chamada assincrona
    showDatePicker(context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2019), 
    lastDate: DateTime.now())
    .then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    Container(
      height: 180,
      child: CupertinoDatePicker(mode: CupertinoDatePickerMode.date,
         initialDateTime: DateTime.now(), 
         minimumDate: DateTime(2019),
         maximumDate: DateTime.now(),
         onDateTimeChanged: onDateChanged,
      ),
    )
    :
    Container(
      height: 70,
      child: Row (children: [
        Expanded(
          child: Text(selectedDate == null ? 'Nenhuma data selecionada': 
            'Data selecionada ${DateFormat('dd/MM/y').format(selectedDate)}'
          ),
        ),
        TextButton(
            onPressed: () => _showDatePicker(context),
            child: Text("Selecionar data"),
            style: TextButton.styleFrom(
                primary: Colors.purple,
                textStyle: TextStyle(fontSize: 18,
                 color: Colors.purple,
                 fontWeight: FontWeight.bold)
            ),
          ),
      ],),
    );
  }
}