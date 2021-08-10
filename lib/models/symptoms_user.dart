class SymptomsUser {
  int id;
  List<String> symptoms;
  DateTime symptomsDate;
  String remarks;
  bool isCovid;
  DateTime covidDate;

  SymptomsUser(
      {this.id,
      this.symptoms = const [],
      this.symptomsDate,
      this.remarks = '',
      this.isCovid = false,
      this.covidDate});

  factory SymptomsUser.fromJson(Map<String, dynamic> json) {
    return SymptomsUser(
        id: json['_id'],
        symptomsDate: json['symptomDate'],
        remarks: json['remarks'],
        isCovid: json['isCovid'],
        covidDate: json['covidDate']);
  }
  Map<String, dynamic> toJson() => {
        'symptoms': this.symptoms,
        'symptomDate': this.symptomsDate,
        'remarks': this.remarks,
        'isCovid': this.isCovid,
        'covidDate': this.covidDate,
      };
  String toString() {
    return toJson().toString();
  }
}
