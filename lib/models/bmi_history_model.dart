class BMIHistory {
  final double bmi;
  final String bmiCategory;
  final String bmiRange;
  final DateTime timestamp;

  BMIHistory({
    required this.bmi,
    required this.bmiCategory,
    required this.bmiRange,
    required this.timestamp,
  });

  factory BMIHistory.fromJson(Map<String, dynamic> json) {
    return BMIHistory(
      bmi: double.tryParse(json['bmi'].toString()) ?? 0.0,
      bmiCategory: json['bmi_category'],
      bmiRange: json['bmi_range'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bmi': bmi.toStringAsFixed(1),
      'bmi_category': bmiCategory,
      'bmi_range': bmiRange,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
