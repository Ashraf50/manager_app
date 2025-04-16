import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/widget/custom_search.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/add_button.dart';
import 'package:manager_app/features/all_tickets/presentation/view/widget/all_tickets_list_view.dart';
import '../../../../../core/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllTicketsViewBody extends StatelessWidget {
  const AllTicketsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            CustomSearch(
              controller: TextEditingController(),
              hintText: "search",
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(
                    "10",
                    style: AppStyles.textStyle18bold,
                  ),
                ),
                AddButton(
                  title: "Create New",
                  onTap: () {
                    context.push("/create_ticket");
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const AllTicketsListView(),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
