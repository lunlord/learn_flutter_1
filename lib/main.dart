import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          fontFamily: 'Montserrat'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //   Transaction(
    //     id: '1',
    //     name: 'новая обувь',
    //     price: 1999.9,
    //     dateTime: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: '2',
    //     name: 'купил еду',
    //     price: 300,
    //     dateTime: DateTime.now(),
    //   ),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txName, double txPrice) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        name: txName,
        dateTime: DateTime.now(),
        price: txPrice);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _StartAddNewTrans(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter App',
        ),
        actions: [
          IconButton(
            onPressed: () => _StartAddNewTrans(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionWidget(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _StartAddNewTrans(context);
        },
      ),
    );
  }
}
