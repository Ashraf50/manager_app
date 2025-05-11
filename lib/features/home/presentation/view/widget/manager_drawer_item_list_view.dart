import 'package:manager_app/core/constant/app_images.dart';
import 'package:manager_app/features/home/data/model/drawer_model.dart';
import 'package:manager_app/features/home/presentation/view/widget/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/generated/l10n.dart';

class ManagerDrawerItemsListView extends StatelessWidget {
  final int activeIndex;
  final Function(int) onItemSelected;
  const ManagerDrawerItemsListView({
    super.key,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<DrawerItemModel> items = [
      DrawerItemModel(
        title: S.of(context).dashboard,
        image: Assets.dashboard,
      ),
      DrawerItemModel(
        title: S.of(context).allTickets,
        image: Assets.ticket,
      ),
      DrawerItemModel(
        title: S.of(context).chat,
        image: Assets.chat,
      ),
      DrawerItemModel(
        title: S.of(context).addTicketian,
        image: Assets.addTicketian,
      ),
      DrawerItemModel(
        title: S.of(context).setting,
        image: Assets.settings,
      ),
    ];
    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onItemSelected(index);
            context.go("/manager_home", extra: index);
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: DrawerItem(
              drawerItemModel: items[index],
              isActive: activeIndex == index,
            ),
          ),
        );
      },
    );
  }
}
