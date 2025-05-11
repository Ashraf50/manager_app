import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_images.dart';
import 'package:manager_app/core/helper/api_helper.dart';
import 'package:manager_app/features/Auth/data/repo/auth_repo.dart';
import 'package:manager_app/features/Auth/data/repo/auth_repo_impl.dart';
import 'package:manager_app/features/home/presentation/view/widget/active_and_inactive_item.dart';
import 'package:manager_app/features/home/presentation/view/widget/manager_drawer_item_list_view.dart';
import 'package:manager_app/features/home/presentation/view/widget/user_info.dart';
import 'package:manager_app/generated/l10n.dart';
import '../../../data/model/drawer_model.dart';

class ManagerDrawer extends StatelessWidget {
  final int activeIndex;
  final Function(int) onItemSelected;
  const ManagerDrawer({
    super.key,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: MediaQuery.sizeOf(context).width * .7,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: UserInfoListTile(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 8.h,
            ),
          ),
          ManagerDrawerItemsListView(
            activeIndex: activeIndex,
            onItemSelected: onItemSelected,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 20.h,
                )),
                InkWell(
                  onTap: () {
                    context.go('/sign_in');
                    AuthRepo authRepo = AuthRepoImpl(ApiHelper());
                    authRepo.logout();
                  },
                  child: InActiveDrawerItem(
                    drawerItemModel: DrawerItemModel(
                      title: S.of(context).logoutAccount,
                      image: Assets.logout,
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.h,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
