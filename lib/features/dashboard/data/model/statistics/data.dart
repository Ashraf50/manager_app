import 'annual_tickets_average.dart';
import 'recent_ticket.dart';

class Data {
  int? techniciansCount;
  int? allTickets;
  int? openedTickets;
  int? inProcessingTickets;
  int? closedTickets;
  List<AnnualTicketsAverage>? annualTicketsAverage;
  List<RecentTicket>? recentTickets;

  Data({
    this.techniciansCount,
    this.allTickets,
    this.openedTickets,
    this.inProcessingTickets,
    this.closedTickets,
    this.annualTicketsAverage,
    this.recentTickets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        techniciansCount: json['technicians_count'] as int?,
        allTickets: json['all_tickets'] as int?,
        openedTickets: json['opened_tickets'] as int?,
        inProcessingTickets: json['in_processing_tickets'] as int?,
        closedTickets: json['closed_tickets'] as int?,
        annualTicketsAverage: (json['annual_tickets_average'] as List<dynamic>?)
            ?.map(
                (e) => AnnualTicketsAverage.fromJson(e as Map<String, dynamic>))
            .toList(),
        recentTickets: (json['recent_tickets'] as List<dynamic>?)
            ?.map((e) => RecentTicket.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'technicians_count': techniciansCount,
        'all_tickets': allTickets,
        'opened_tickets': openedTickets,
        'in_processing_tickets': inProcessingTickets,
        'closed_tickets': closedTickets,
        'annual_tickets_average':
            annualTicketsAverage?.map((e) => e.toJson()).toList(),
        'recent_tickets': recentTickets?.map((e) => e.toJson()).toList(),
      };
}
