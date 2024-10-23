import 'package:flutter/material.dart';
import 'package:flutter_application_1_introdection_my_wallet/data/getdatahive.dart';

class EditTransactionPage extends StatefulWidget {
  final Add_data transaction;

  const EditTransactionPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  _EditTransactionPageState createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _explainController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with current transaction data
    _nameController = TextEditingController(text: widget.transaction.name);
    _amountController = TextEditingController(text: widget.transaction.amount);
    _explainController = TextEditingController(text: widget.transaction.explain);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _explainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Edit Transaction'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save the updated transaction data
              widget.transaction.name = _nameController.text;
              widget.transaction.amount = _amountController.text;
              widget.transaction.explain = _explainController.text;
              widget.transaction.save();

              Navigator.pop(context); // Return to the previous screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Transaction Name'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _explainController,
              decoration: InputDecoration(labelText: 'Explanation'),
            ),
            // You can add more fields to edit other properties if needed
          ],
        ),
      ),
    );
  }
}
