import 'package:flutter/material.dart';
import 'package:incomeexpensetrackerapp/transaction_provider.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isIncome = true;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<TransactionProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 168, 248),
      appBar: AppBar(

        title: Text("Add Transaction",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _amountController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'Enter valid amount'
                        : null,
              ),
               SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTypeButton('Income', Colors.green, true),
                   Spacer(),
                  _buildTypeButton('Expense', Colors.red, true),
                ],
              ),
               SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final amount =
                        double.tryParse(_amountController.text) ?? 0.0;
                    provider.addTransaction(
                        _titleController.text, amount, _isIncome);
                    Navigator.pop(context);
                  }
                },style: ElevatedButton.styleFrom(foregroundColor: Colors.blue[50], backgroundColor: Colors.blue[800],minimumSize: Size(double.infinity, 50)),
                child:  Text("Add Transaction"),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTypeButton(String label,Color color, bool isIncomeType){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(100, 50),
        backgroundColor: _isIncome ==isIncomeType ? color:Colors.grey[300],
        foregroundColor: _isIncome == isIncomeType ? Colors.white : Colors.black,
        padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 12),

      ),
      onPressed: (){
      setState(() {
        _isIncome=isIncomeType;
      });
    }, child: Text(label));
  }
}
