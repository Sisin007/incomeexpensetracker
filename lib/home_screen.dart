import 'package:flutter/material.dart';
import 'package:incomeexpensetrackerapp/add_transaction_screen.dart';
import 'package:incomeexpensetrackerapp/transaction_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 237, 168, 248),
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            foregroundColor: Colors.black,
            title:  Text("Tracker", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryCard(
                        'Income', provider.totalIncome, Colors.green),
                    _buildSummaryCard(
                        'Expense', provider.totalExpense, Colors.red),
                    _buildSummaryCard(
                        'Balance', provider.balance, Colors.blue),
                  ],
                ),
              ),
               Divider(
                color: Colors.blue[800],
               ),
              Expanded(
                child: provider.transaction.isEmpty
                    ?  Center(child: Text('No transaction yet!'))
                    : ListView.builder(
                        itemCount: provider.transaction.length,
                        itemBuilder: (context, index) {
                          final t = provider.transaction[index];
                          final amount =
                              (t['amount'] as num).toDouble(); // SAFE
                          return ListTile(
                            title: Text(t['title']),
                            subtitle: Text(t['date'].split('T')[0]),
                            trailing: Text(
                              '${t['isIncome'] ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: t['isIncome']
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                            onLongPress: () =>
                                provider.deleteTransaction(index),
                          );
                         
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>  AddTransactionScreen(),
                ),
              );
            },
            backgroundColor: Colors.blue[50],
            child:  Icon(Icons.add, color: Colors.blue[800],),
          ),
        );
      },
    );
  }


  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Card(
      color: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.all(12),
        width: 100,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
