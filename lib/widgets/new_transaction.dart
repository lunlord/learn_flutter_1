import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addFunction;

  NewTransaction(this.addFunction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _pickedDate;

  void _submitData() {
    final enteredTitle = _nameController.text;
    final enteredPrice = double.parse(_priceController.text);

    if (enteredTitle.isEmpty || enteredPrice <= 0 || _pickedDate == null) {
      return;
    }

    widget.addFunction(enteredTitle, enteredPrice, _pickedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Название'),
              controller: _nameController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Цена'),
              controller: _priceController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    _pickedDate == null
                        ? 'дата не выбрана'
                        : 'Выбранная дата: ${DateFormat.yMd().format(_pickedDate)}',
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: _datePicker,
                      child: Text(
                        'Выбрать дату',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Создать'),
            ),
          ],
        ),
      ),
    );
  }
}
