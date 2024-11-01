class EarningsTranscript {
  final String content;

  EarningsTranscript({required this.content});

  factory EarningsTranscript.fromJson(Map<String, dynamic> json) {
    return EarningsTranscript(content: json['content']);
  }
}
