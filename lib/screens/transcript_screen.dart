import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/earnings_api.dart';

class TranscriptScreen extends StatefulWidget {
  final String ticker;
  final int year;
  final int quarter;

  TranscriptScreen(
      {required this.ticker,
      required this.year,
      required this.quarter,
      required String transcript,
      required RxBool isLoading});

  @override
  _TranscriptScreenState createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  String? transcript;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTranscript();
  }

  Future<void> fetchTranscript() async {
    try {
      final result = await EarningsApi.fetchTranscript(
          widget.ticker, widget.year, widget.quarter);
      setState(() {
        transcript = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        transcript = 'Failed to load transcript';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.ticker} Transcript')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: transcript != null
                    ? Text(
                        transcript!,
                        style: TextStyle(fontSize: 16),
                      )
                    : Column(
                        children: [
                          const Text(
                            "errorMessage",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: fetchTranscript,
                            child: Text('Retry'),
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}
