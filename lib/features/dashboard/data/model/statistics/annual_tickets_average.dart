class AnnualTicketsAverage {
  int? year;
  int? count;

  AnnualTicketsAverage({this.year, this.count});

  factory AnnualTicketsAverage.fromJson(Map<String, dynamic> json) {
    return AnnualTicketsAverage(
      year: json['year'] as int?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'year': year,
        'count': count,
      };
}
