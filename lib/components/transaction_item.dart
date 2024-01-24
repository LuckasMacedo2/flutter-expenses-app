import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String p1) onRemove;
  
  const TransactionItem({
    super.key,  // Definir um elemento dentro de um contexto, é a chave daquele elemento
    required this.tr,
    required this.onRemove,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(colors.length);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox (
              child: Text('R\$ ${widget.tr.value}')
              ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width <  400 ?
        IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.onRemove(widget.tr.id),
        ) :
        TextButton.icon(
          icon: Icon(Icons.delete),
          onPressed: () => widget.onRemove(widget.tr.id),
          label: Text('Excluir',),
          style: TextButton.styleFrom(
              primary: Theme.of(context).errorColor,
              textStyle: TextStyle(fontSize: 18,
               color: Theme.of(context).errorColor,
               fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }
}
