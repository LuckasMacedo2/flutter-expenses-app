import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransaction);

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for(var i = 0; i < recentTransaction.length; i++){
        bool sameday = recentTransaction[i].date.day == weekday.day;
        bool sameMonth = recentTransaction[i].date.month == weekday.month;
        bool sameYear = recentTransaction[i].date.year == weekday.year;

        if(sameday && sameMonth && sameYear){
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekday)[0], 
        'value': totalSum
        };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(label: tr['day'].toString()
              , value: double.tryParse(tr['value'].toString()), 
              pecentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / (_weekTotalValue)),
            );
          }).toList(),
        ),
      ),
    );
  }
}