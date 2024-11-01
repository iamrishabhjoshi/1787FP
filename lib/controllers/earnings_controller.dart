import 'package:get/get.dart';
import '../api/earnings_api.dart';
import '../models/earnings.dart';

class EarningsController extends GetxController {
  var earnings = <Earnings>[].obs;
  var isLoadingTranscript = false.obs;
  var transcript = ''.obs;
  Future<void> fetchEarningsData(String ticker) async {
    try {
      final data = await EarningsApi.fetchEarnings(ticker);
      earnings.value = data..sort((a, b) => a.date.compareTo(b.date)); // Sort by date
    } catch (e) {
      print("Error fetching earnings data: $e");
    }
  }
  Future<void> fetchEarningsTranscript(String ticker, int year, int quarter) async {
    isLoadingTranscript.value = true; // Set loading state to true
    try {
      // Fetch the transcript using the API method
      final fetchedTranscript = await EarningsApi.fetchTranscript(ticker, year, quarter);
      transcript.value = fetchedTranscript; // Update the observable transcript with the fetched data
    } catch (e) {
      print("Error fetching earnings transcript: $e");
      transcript.value = "Error loading transcript."; // Optional: Set error message in transcript
    } finally {
      isLoadingTranscript.value = false; // Reset loading state
    }
  }
}
