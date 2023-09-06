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
      final expenseList =
          querySnapshot.docs.map((doc) => Expense.fromMap(doc.data())).toList();
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
    return expenses
        .where((expense) => expense.farmcode == selectedFarmCode)
        .toList();
  }

  double getExpenseTotalCost() {
    return expenses
        .where((expense) => expense.farmcode == selectedExpense)
        .map((expense) => expense.cost)
        .fold(0, (previous, current) => previous + current);
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
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                height: 430,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 6,
                      color: Color(0xff000000).withOpacity(0.16),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 19.0),
                      child: Text(
                        "FARM TOTAL",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Select from the drop down to select Farm ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Total Cost: \GHS${getTotalCost().toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: firestore
                              .collection('Expenses')
                              .where('Farm', isEqualTo: selectedGroup)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            List<ExpenseItem> expenseItems = [];
                            int totalCost = 0;

                            snapshot.data!.docs.forEach((doc) {
                              final expenseName = doc['name'];
                              final cost = doc['Cost'] as int;
                              totalCost += cost;

                              expenseItems.add(ExpenseItem(expenseName, cost));
                            });

                            return Column(
                              children: [
                                Divider(),
                                Text(
                                  "Cost Per Item",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemExtent: 50.0,
                                    itemCount: expenseItems.length,
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                        child: ListTile(
                                          title: Text(expenseItems[index].name),
                                          subtitle: Text(
                                              'Cost: \GHS${expenseItems[index].cost}'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Text(
                                  'Total Cost: \GHS${totalCost.toString()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 6,
                      color: Color(0xff000000).withOpacity(0.16),
                    ),
                  ],
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      "EXPENSE TOTAL",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
          ],
        ),
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

class ExpenseItem {
  final String name;
  final int cost;

  ExpenseItem(this.name, this.cost);
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

  Expense(
      {required this.group,
      this.location,
      required this.farmcode,
      this.quantity,
      this.name,
      required this.cost});

  factory Expense.fromMap(Map<dynamic, dynamic> map) {
    return Expense(
        group: map['Farm'],
        cost: map['Cost'].toDouble(),
        farmcode: map["FarmCodes"]);
  }
}
