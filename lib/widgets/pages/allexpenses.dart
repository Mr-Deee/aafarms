import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/addedFarm.dart';

class allexpenses extends StatefulWidget {
  const allexpenses({Key? key}) : super(key: key);

  @override
  State<allexpenses> createState() => _allexpensesState();
}

class _allexpensesState extends State<allexpenses> {
  late CollectionReference<Map<String, dynamic>> _expensesRef;  List<Expense> expenses = [];
  String selectedGroup = 'Group A';




  @override
  void initState() {
    super.initState();
    _expensesRef = FirebaseFirestore.instance.collection('Expenses');
    _expensesRef.get().then((querySnapshot) {
      final expenseList = querySnapshot.docs
          .map((doc) => Expense.fromMap(doc.data()))
          .toList();
      setState(() {
        expenses = expenseList;
      });
    });
  }

  double getTotalCost() {
    return expenses
        .where((expense) => expense.group == selectedGroup)
        .map((expense) => expense.cost)
        .fold(0, (previous, current) => previous + current);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedGroup,
            onChanged: (String? newValue) {
              setState(() {
                selectedGroup = newValue!;
              });
            },
            items: expenses
                .map((expense) => expense.group)
                .toSet()
                .toList()
                .map((group) => DropdownMenuItem<String>(
              value: group,
              child: Text(group),
            ))
                .toList(),
          ),
          SizedBox(height: 16),
          Text(
            'Total Cost: \$${getTotalCost().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class Expense {
  final String group;
  final double cost;

  Expense({required this.group, required this.cost});

  factory Expense.fromMap(Map<dynamic, dynamic> map) {
    return Expense(
      group: map['Farm'],
      cost: map['Cost'].toDouble(),
    );
  }
}



