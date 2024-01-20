import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import 'adaptative_text_fiel.dart';

class TransactionForm extends StatefulWidget {
  
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    bottom: 10 + MediaQuery.of(context).viewInsets.bottom // Obtémm o tamanho do teclado (tamanho abaixo da view)
                    ),
                  child: Column(
                  children: <Widget>[
                      AdaptativeTextField(
                        controller: _titleController,
                        onSubmit: (_) => _submitForm(),
                        label: 'Título'
                      ),
                      AdaptativeTextField(
                        controller: _valueController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onSubmit: (_) => _submitForm(),
                        label:  'Valor (R\$)'
                      ),
                      adaptativeDatePicker(selectedDate: _selectedDate, onDateChanged: (newDate) {
                        setState(() {
                          _selectedDate = newDate;
                        });
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AdaptativeButton(label: "Nova transação", onPressed: _submitForm)
                        ],
                      )
                    ],
                  ),
                ),
          ),
    );
  }
}