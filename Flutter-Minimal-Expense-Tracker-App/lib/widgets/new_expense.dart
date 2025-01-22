import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  Category? _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountisInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountisInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure that all the fields have valid inputs!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(Expense(
        amount: enteredAmount,
        title: _titleController.text,
        date: _selectedDate!,
        category: _selectedCategory!));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label:
                                  Text('Title', style: TextStyle(fontSize: 13)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              prefixText: '₹',
                              label: Text('Amount',
                                  style: TextStyle(fontSize: 13)),
                            ),
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    )
                  else
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Title', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          itemHeight: 48.0,
                          value: _selectedCategory,
                          menuWidth: 95,
                          menuMaxHeight: 150,
                          // alignment: AlignmentDirectional.center,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  enabled: true,
                                  alignment: Alignment.center,
                                  value: category,
                                  child: Text(
                                    style: const TextStyle(fontSize: 12),
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (_selectedCategory == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          hint: const Text(
                            'Choose',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  _selectedDate == null
                                      ? 'Select date'
                                      : formatter.format(_selectedDate!),
                                  style: const TextStyle(fontSize: 13)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                                style: IconButton.styleFrom(iconSize: 23),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              prefixText: '₹',
                              label: Text('Amount',
                                  style: TextStyle(fontSize: 13)),
                            ),
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  _selectedDate == null
                                      ? 'Select date'
                                      : formatter.format(_selectedDate!),
                                  style: const TextStyle(fontSize: 13)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                                style: IconButton.styleFrom(iconSize: 23),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel',
                              style: TextStyle(fontSize: 13)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4)),
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense',
                              style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        DropdownButton(
                          itemHeight: 48.0,
                          value: _selectedCategory,
                          menuWidth: 95,
                          menuMaxHeight: 150,
                          // alignment: AlignmentDirectional.center,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  enabled: true,
                                  alignment: Alignment.center,
                                  value: category,
                                  child: Text(
                                    style: const TextStyle(fontSize: 12),
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (_selectedCategory == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          hint: const Text(
                            'Choose',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel',
                              style: TextStyle(fontSize: 13)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4)),
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense',
                              style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
