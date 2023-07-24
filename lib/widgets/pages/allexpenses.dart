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
   CollectionReference<Map<String, dynamic>>? _expensesRef;
   late CollectionReference<Map<String, dynamic>> _farmCodesRef;
   List<Expense> expenses = [];
  String selectedGroup = '';
  String selectedExpense = '';
   List<FarmCode> farmCodes = [];
   String selectedFarmCode = '';
   double farmCodeCost = 0.0;




  @override
  void initState() {
    super.initState();
getexpenseTotalCost();
getSelectedExpenses();

    _farmCodesRef = FirebaseFirestore.instance.collection('farmCodes');
    _expensesRef = FirebaseFirestore.instance.collection('Expenses');
    _expensesRef!.get().then((querySnapshot) {
      final expenseList = querySnapshot.docs
          .map((doc) => Expense.fromMap(doc.data()))
          .toList();
      setState(() {
        expenses = expenseList;
        selectedGroup = expenses.isNotEmpty ? expenses[0].group : '';
        selectedExpense = expenses.isNotEmpty ? expenses[0].farmcode : '';
      });
    });


    _farmCodesRef.get().then((querySnapshot) {
      final farmCodeList = querySnapshot.docs
          .map((doc) => FarmCode.fromMap(doc.data()))
          .toList();
      setState(() {
        farmCodes = farmCodeList;
        selectedFarmCode = farmCodes.isNotEmpty ? farmCodes[0].code : '';
        farmCodeCost = farmCodes.isNotEmpty ? farmCodes[0].cost : 0.0;
      });
    });
  }



  double getTotalCost() {
    return expenses
        .where((expense) => expense.group == selectedGroup)
        .map((expense) => expense.cost)
        .fold(0, (previous, current) => previous + current);
  }

   List<Expense> getSelectedExpenses() {
     return expenses.where((expense) => expense.farmcode == selectedFarmCode).toList();
   }

   double getexpenseTotalCost() {
     double totalCost = 0.0;
     print('Selected Farm Code: $selectedExpense');
     for (var expense in expenses) {
       print('Expense - Farm Code: ${expense.farmcode}, Cost: ${expense.cost}');
       if (expense.farmcode == selectedExpense) {
         totalCost += expense.cost;
       }
     }
     print('Total Expense Cost: $totalCost');
     return totalCost;
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField<String>(
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
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Total Cost: \GHS${getTotalCost().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),

      Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DropdownButtonFormField<String>(
              value: selectedExpense,
              onChanged: (String? newVal) {
                setState(() {
                  selectedExpense = newVal!;
                });
              },
              items: expenses
                  .map((expense) => expense.farmcode)
                  .toSet()
                  .toList()
                  .map((farmcode) => DropdownMenuItem<String>(
                value: farmcode,
                child: Text(farmcode),
              ))
                  .toList(),
            ),
          ),

          Text(
            'Total Cost: \GHS${getexpenseTotalCost().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ]
      ),

          // Container(
          //   height: 200,
          //   child: ListView.builder(
          //     itemCount: getSelectedExpenses().length,
          //     itemBuilder: (context, index) {
          //       final expense = getSelectedExpenses()[index];
          //       return ListTile(
          //         title: Text(expense.farmcode),
          //         subtitle: Text('Cost: \$${expense.cost.toStringAsFixed(2)}'),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
class FarmCode {
  final String code;
  final double cost;

  FarmCode({required this.code, required this.cost});

  factory FarmCode.fromMap(Map<String, dynamic> map) {
    return FarmCode(
      code: map['code'],
      cost: map['cost'].toDouble(),
    );
  }
}
class Expense {
  final String group;
  final double cost;
  String? name;
  String farmcode;

  String? location;
  String? company;
  int? quantity;
  String? image;
  String? description;

  Expense({required this.group, this.location, required this.farmcode,this.quantity,this.name, required this.cost});

  factory Expense.fromMap(Map<dynamic, dynamic> map) {
    return Expense(
      group: map['Farm'],
      cost: map['Cost'].toDouble(),
      farmcode: map["FarmCodes"]
    );
  }
}



