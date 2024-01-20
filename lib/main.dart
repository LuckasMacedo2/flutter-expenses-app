import 'dart:io';

import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Configurando a orientação da aplicação
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);*/

    return MaterialApp(
        home: MyHomePage(),
        // Tema do app
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    titleLarge: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = 
    AppBar(
      title: Text('Despesas Pessoais'),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*if(isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Exibir gráfico'),
                    Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart, 
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }
                    ),
                  ],
                ),*/
            if (_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 0.8 : 0.3),
                  child: Chart(_recentTransactions)),
            if (_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 1 : 0.7),
                  child: TransactionList(_transactions, _deleteTransaction)),
          ],
        ),
      ),
    );

    return /*Platform.isIOS
        ? CupertinoPageScaffold(
          navigationBar: appBar,
          child: bodyPage
        )
        :*/ Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton:
                /*Platform.isIOS ? 
      Container() :*/
                FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
