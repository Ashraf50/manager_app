import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/add_ticketian/presentation/view_model/cubit/add_ticketian_cubit.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../../../core/widget/drop_down_text_field.dart';
import '../../view_model/cubit/ticket_cubit.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({super.key});

  @override
  SortDialogState createState() => SortDialogState();
}

class SortDialogState extends State<SortDialog> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  int? selectedTicketianId;
  TicketianModel? selectedTicketian;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd', 'en').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).filterTickets),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _selectDate(context, fromController),
            child: AbsorbPointer(
              child: TextField(
                controller: fromController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: S.of(context).from,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _selectDate(context, toController),
            child: AbsorbPointer(
              child: TextField(
                controller: toController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: S.of(context).to,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<AddTicketianCubit, AddTicketianState>(
            builder: (context, state) {
              if (state is FetchAllTicketianLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllTicketianFailure) {
                return Text(state.errMessage);
              } else if (state is FetchAllTicketianSuccess) {
                return DropdownTextField(
                  ticketian: state.ticketian,
                  selectedTicketian: selectedTicketian,
                  onChanged: (record) {
                    setState(() {
                      selectedTicketian = record;
                      selectedTicketianId = record.id;
                    });
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            String from = fromController.text;
            String to = toController.text;
            int ticketianId = selectedTicketianId ?? 0;
            context.read<TicketCubit>().fetchSortedTickets(
                from: from, to: to, ticketianId: ticketianId);
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).apply),
        ),
        TextButton(
          onPressed: () {
            context.read<TicketCubit>()
              ..currentPage = 1
              ..hasMore = true
              ..allTickets.clear()
              ..fetchTickets();
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).showAll),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).cancel),
        ),
      ],
    );
  }
}
