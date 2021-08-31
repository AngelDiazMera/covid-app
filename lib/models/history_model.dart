class HistoryModel {
  int? id;
  DateTime time;
  String status; // none, risk, infected
  String symptoms; // symptom1, symptom2, etc...

  String get parsedStatus {
    Map<String, String> parser = {
      'none': 'Riesgo bajo',
      'risk': 'En riesgo',
      'infected': 'Contagiado',
    };
    return parser[status]!;
  }

  HistoryModel({
    this.id,
    required this.time,
    required this.status,
    required this.symptoms,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      time: DateTime.parse(json['time']),
      status: json['status'],
      symptoms: json['symptoms'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'time': this.time.toUtc().toString(),
        'status': this.status,
        'symptoms': this.symptoms,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
