import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_app_bar.dart';
import 'package:manager_app/core/widget/custom_scaffold.dart';
import 'package:manager_app/features/add_ticketian/data/model/ticketian_model/ticketian_model.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/ticket_details_view.dart';
import 'package:manager_app/generated/l10n.dart';

class TicketianDetailsView extends StatelessWidget {
  final TicketianModel ticketian;
  const TicketianDetailsView({
    super.key,
    required this.ticketian,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar:  CustomAppBar(title:S.of(context).ticketian_details ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                context.push(
                  '/photo_view',
                  extra: ticketian.user!.avatar!,
                );
              },
              child: CircleAvatar(
                radius: 100,
                child: ClipOval(
                  child: Image.network(
                    ticketian.user!.avatar!,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                ticketian.user?.name ?? "N/A",
                style: AppStyles.textStyle18black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomWidget(
              title: '${S.of(context).Email}: ',
              subTitle: ticketian.user?.email ?? "N/A",
            ),
            CustomWidget(
              title: '${S.of(context).phone}: ',
              subTitle: ticketian.user?.phone ?? "N/A",
            ),
          ],
        ),
      ),
    );
  }
}
