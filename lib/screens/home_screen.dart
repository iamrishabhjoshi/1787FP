import 'package:flutter/material.dart';
import '../controllers/earnings_controller.dart';
import 'earnings_chart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EarningsController controller = EarningsController();
  final TextEditingController tickerController = TextEditingController();
  bool isLoading = false;

  void _submitTicker() async {
    final ticker = tickerController.text.trim();
    if (ticker.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      try {
        await controller.fetchEarningsData(ticker);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EarningsChartScreen(
              controller: controller,
              ticker: ticker,
            ),
          ),
        );
      } catch (e) {
        // Handle any errors, if needed
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings Tracker'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GestureDetector(
        onTap: () {
         
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.blue[50],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Track Company Earnings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: tickerController,
                decoration: InputDecoration(
                  labelText: 'Enter Company Ticker',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: isLoading ? null : _submitTicker,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
