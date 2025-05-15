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

class ManagerDrawer extends StatefulWidget {
  final int activeIndex;
  final Function(int) onItemSelected;
  const ManagerDrawer({
    super.key,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  State<ManagerDrawer> createState() => _ManagerDrawerState();
}

class _ManagerDrawerState extends State<ManagerDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              _slideAnimation.value * MediaQuery.of(context).size.width, 0),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                width: MediaQuery.sizeOf(context).width * .7,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      spreadRadius: 3,
                      offset: const Offset(2, 0),
                    ),
                  ],
                ),
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
                      activeIndex: widget.activeIndex,
                      onItemSelected: widget.onItemSelected,
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 20.h,
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: InkWell(
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
                          ),
                          SizedBox(
                            height: 48.h,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
