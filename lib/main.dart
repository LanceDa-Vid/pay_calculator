import 'package:flutter/material.dart';

void main() {
  runApp(PayCalculatorApp());
}

class PayCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PayCalculatorScreen(),
    );
  }
}

class PayCalculatorScreen extends StatefulWidget {
  @override
  _PayCalculatorScreenState createState() => _PayCalculatorScreenState();
}

class _PayCalculatorScreenState extends State<PayCalculatorScreen> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  double regularPay = 0;
  double overtimePay = 0;
  double totalPay = 0;
  double tax = 0;

  void _calculatePay() {
    final double hoursWorked = double.tryParse(_hoursController.text) ?? 0;
    final double hourlyRate = double.tryParse(_rateController.text) ?? 0;

    if (hoursWorked <= 40) {
      regularPay = hoursWorked * hourlyRate;
      overtimePay = 0;
    } else {
      regularPay = 40 * hourlyRate;
      overtimePay = (hoursWorked - 40) * hourlyRate * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }

  void _clearFields() {
    _hoursController.clear();
    _rateController.clear();
    setState(() {
      regularPay = 0;
      overtimePay = 0;
      totalPay = 0;
      tax = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Hours Worked',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Hourly Rate',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _calculatePay,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(180, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text('Calculate'),
                ),
                ElevatedButton(
                  onPressed: _clearFields,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(180, 50),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Regular Pay: \$${regularPay.toStringAsFixed(2)}'),
                  Text('Overtime Pay: \$${overtimePay.toStringAsFixed(2)}'),
                  Text('Total Pay (Before Tax): \$${totalPay.toStringAsFixed(2)}'),
                  Text('Tax (18%): \$${tax.toStringAsFixed(2)}'),
                ],
              ),
            ),
            Spacer(),
            Divider(),
            Center(
              child: Text(
                'Your Full Name - Student ID',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
