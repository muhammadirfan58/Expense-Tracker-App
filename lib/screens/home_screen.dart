import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';
import '../widgets/expense_card.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          final expenses = provider.expenses;

          return Column(
            children: [
              // Total Expense
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total Expense',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rs. ${provider.totalExpense.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Expense List
              Expanded(
                child: expenses.isEmpty
                    ? const Center(
                        child: Text(
                          'No expenses yet',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final expense = expenses[index];

                          return ExpenseCard(
                            expense: expense,
                            onDelete: () {
                              provider.deleteExpense(
                                expense.id!,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),

      // Add Expense Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
