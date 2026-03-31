import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:incomeexpensetrackerapp/home_screen.dart';
import 'package:incomeexpensetrackerapp/transaction_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('transaction');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionProvider(),
      child: MaterialApp(
        title: 'Income and Expense Tracker',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
