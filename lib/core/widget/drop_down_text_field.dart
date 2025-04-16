import 'package:manager_app/core/constant/app_styles.dart';
import 'package:flutter/material.dart';

class DropdownTextField extends StatefulWidget {
  const DropdownTextField({super.key});

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  String? selectedDepartment;
  final List<String> departments = [
    'Marketing',
    'Sales',
    'Engineering',
    'Human Resources',
    'Finance'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: Colors.white,
          value: selectedDepartment,
          hint: Text(
            'Select department',
            style: AppStyles.textStyle16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          items: departments.map((String department) {
            return DropdownMenuItem<String>(
              value: department,
              child: Text(department),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(
              () {
                selectedDepartment = newValue;
              },
            );
          },
        ),
      ),
    );
  }
}
