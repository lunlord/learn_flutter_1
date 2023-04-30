import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String name;
  final DateTime dateTime;
  final double price;

  Transaction(
      {@required this.id,
      @required this.name,
      @required this.dateTime,
      @required this.price});
}
