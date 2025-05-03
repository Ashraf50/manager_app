import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_images.dart';
import 'package:manager_app/core/helper/firebase_notification_helper.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/dashboard/presentation/view/widget/graph.dart';
import '../../../../all_tickets/presentation/view_model/cubit/ticket_cubit.dart';
import 'custom_card.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  @override
  void initState() {
    super.initState();
    FirebaseNotificationsHelper(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<TicketCubit, TicketState>(
          builder: (context, state) {
            if (state is FetchTicketLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchTicketFailure) {
              return Center(child: Text(state.errMessage));
            } else if (state is FetchTicketSuccess) {
              final tickets = state.tickets;
              final totalTickets = tickets.length;
              final closedTickets = tickets.where((t) => t.status == 3).length;
              final openTickets = tickets.where((t) => t.status == 1).length;
              final closedPercentage = totalTickets > 0
                  ? ((closedTickets / totalTickets) * 100).round()
                  : 0;
              final openPercentage = totalTickets > 0
                  ? ((openTickets / totalTickets) * 100).round()
                  : 0;
              const userCount = 6; // From your screenshot
              const userPercentage = 100; // From your screenshot
              return Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: constraints.maxWidth < 600 ? 2 : 4,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.85,
                        children: [
                          CustomCard(
                            title: "All Tickets",
                            value: totalTickets.toString(),
                            percentage: "100%",
                            iconAsset: Assets.ticket,
                            circleColor: AppColors.darkBlue,
                          ),
                          CustomCard(
                            title: "Closed Tickets",
                            value: closedTickets.toString(),
                            percentage: "$closedPercentage%",
                            iconAsset: Assets.ticket,
                            circleColor: AppColors.darkBlue,
                          ),
                          CustomCard(
                            title: "Open Tickets",
                            value: openTickets.toString(),
                            percentage: "$openPercentage%",
                            iconAsset: Assets.ticket,
                            circleColor: AppColors.darkBlue,
                          ),
                          CustomCard(
                            title: "Users",
                            value: userCount.toString(),
                            percentage: "$userPercentage%",
                            iconAsset: Assets.users,
                            circleColor: AppColors.darkBlue,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  const ChartsDashboard(),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
