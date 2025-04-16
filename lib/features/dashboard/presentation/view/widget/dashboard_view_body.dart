import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:manager_app/features/dashboard/presentation/view/widget/graph.dart';
import 'custom_card.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        children: [
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(4, (index) => const CustomCard()),
          ),
          const ChartsDashboard(),
        ],
      ),
    );
  }
}
