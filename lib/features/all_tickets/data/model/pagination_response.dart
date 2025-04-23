import 'ticket_model/ticket_model/ticket_model.dart';

class PaginatedTicketsResponse {
  final List<TicketModel> tickets;
  final int currentPage;
  final int lastPage;
  final int total;

  PaginatedTicketsResponse({
    required this.tickets,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}
