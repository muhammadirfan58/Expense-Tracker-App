// This is a basic Flutter widget test for the Expense Tracker app.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/providers/expense_provider.dart';

void main() {
  testWidgets('Expense Tracker smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider<ExpenseProvider>(
        create: (_) => ExpenseProvider(),
        child: const ExpenseTrackerApp(),
      ),
    );

    // Verify that the title 'Expense Tracker' is shown in the AppBar.
    expect(find.text('Expense Tracker'), findsOneWidget);

    // Verify that the total expense starts at Rs. 0.00.
    expect(find.text('Rs. 0.00'), findsOneWidget);

    // Verify that the empty state message 'No expenses yet' is displayed.
    expect(find.text('No expenses yet'), findsOneWidget);
  });
}
