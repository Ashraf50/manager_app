import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_app/features/all_tickets/presentation/view_model/cubit/ticket_cubit.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({super.key});

  @override
  SortDialogState createState() => SortDialogState();
}

class SortDialogState extends State<SortDialog> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController serviceIdController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        fromController.text = DateFormat('yyyy-MM-dd').format(picked);
        toController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sort Tickets"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextField(
                controller: fromController,
                decoration: const InputDecoration(
                  labelText: "from",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextField(
                controller: toController,
                decoration: const InputDecoration(
                  labelText: "to",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: serviceIdController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Enter service ID"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            String from = fromController.text;
            String to = toController.text;
            int serviceId = int.tryParse(serviceIdController.text) ?? 0;
            context
                .read<TicketCubit>()
                .fetchSortedTickets(from: from, to: to, serviceId: serviceId);
            Navigator.of(context).pop();
          },
          child: const Text("Sort"),
        ),
        TextButton(
          onPressed: () {
            context.read<TicketCubit>().fetchTickets();
            Navigator.of(context).pop();
          },
          child: const Text("Show All"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
