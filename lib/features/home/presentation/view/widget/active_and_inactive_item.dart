import 'package:manager_app/core/constant/app_colors.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manager_app/features/home/data/model/drawer_model.dart';

class InActiveDrawerItem extends StatefulWidget {
  const InActiveDrawerItem({
    super.key,
    required this.drawerItemModel,
  });

  final DrawerItemModel drawerItemModel;

  @override
  State<InActiveDrawerItem> createState() => _InActiveDrawerItemState();
}

class _InActiveDrawerItemState extends State<InActiveDrawerItem>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(
          horizontal: _isHovered ? 8 : 0,
          vertical: _isHovered ? 4 : 0,
        ),
        decoration: BoxDecoration(
          color:
              _isHovered ? Colors.grey.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          border: _isHovered
              ? Border.all(
                  color: AppColors.buttonDrawer.withOpacity(0.3), width: 1)
              : null,
        ),
        child: ListTile(
          leading: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: SvgPicture.asset(
                    widget.drawerItemModel.image,
                    colorFilter: _isHovered
                        ? const ColorFilter.mode(
                            AppColors.buttonDrawer,
                            BlendMode.srcIn,
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: _isHovered
                ? AppStyles.textStyle18black.copyWith(
                    color: AppColors.buttonDrawer,
                    fontWeight: FontWeight.w600,
                  )
                : AppStyles.textStyle18black,
            child: FittedBox(
              alignment: AlignmentDirectional.centerStart,
              fit: BoxFit.scaleDown,
              child: Text(
                widget.drawerItemModel.title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActiveDrawerItem extends StatefulWidget {
  const ActiveDrawerItem({
    super.key,
    required this.drawerItemModel,
  });

  final DrawerItemModel drawerItemModel;

  @override
  State<ActiveDrawerItem> createState() => _ActiveDrawerItemState();
}

class _ActiveDrawerItemState extends State<ActiveDrawerItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(
          horizontal: _isHovered ? 18 : 10,
          vertical: _isHovered ? 4 : 0,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonDrawer,
          borderRadius: BorderRadius.circular(13),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.buttonDrawer.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 3,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ListTile(
          leading: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: SvgPicture.asset(
                    widget.drawerItemModel.image,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              );
            },
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppStyles.textStyle18white.copyWith(
              fontWeight: _isHovered ? FontWeight.bold : FontWeight.w600,
              letterSpacing: _isHovered ? 0.5 : 0.0,
            ),
            child: Text(
              widget.drawerItemModel.title,
            ),
          ),
        ),
      ),
    );
  }
}
