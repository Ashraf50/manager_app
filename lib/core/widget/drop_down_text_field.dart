import 'package:flutter/material.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import '../constant/app_colors.dart';

class DropdownTextField extends StatelessWidget {
  final List<TicketianModel> ticketian;
  final ValueChanged<TicketianModel> onChanged;
  final TicketianModel? selectedTicketian;
  const DropdownTextField({
    super.key,
    required this.ticketian,
    required this.onChanged,
    required this.selectedTicketian,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TicketianModel>(
          isExpanded: true,
          value: selectedTicketian,
          dropdownColor: AppColors.white,
          hint: const Text('Select ticketian'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          items: ticketian.map((ticketian) {
            return DropdownMenuItem<TicketianModel>(
              value: ticketian,
              child: Text(ticketian.user!.name!),
            );
          }).toList(),
          onChanged: (record) {
            if (record != null) {
              onChanged(record);
            }
          },
        ),
      ),
    );
  }
}
