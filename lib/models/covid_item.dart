class CovidItem {
  final String province;
  final int new_case;
  final int total_case;
  final int new_death;
  final int total_death;
  final String txn_date;
  CovidItem(
      {required this.province,
      required this.new_case,
      required this.total_case,
      required this.new_death,
      required this.total_death,
      required this.txn_date});

  factory CovidItem.fromJson(Map<String, dynamic> json) {
    return CovidItem(
      province: json['province'],
      new_case: json['new_case'],
      total_case: json['total_case'],
      new_death: json['new_death'],
      total_death: json['total_death'],
      txn_date: json['txn_date'],
    );
  }
}
