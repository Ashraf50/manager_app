import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_app/core/constant/app_styles.dart';
import 'package:manager_app/core/constant/func/data_format.dart';
import 'package:manager_app/features/notification/data/model/notification_model/notification_model.dart';
import 'package:manager_app/features/notification/presentation/view_model/cubit/read_notification_cubit.dart';
import 'package:manager_app/generated/l10n.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final Color notificationColor;
  const NotificationCard({
    super.key,
    required this.notification,
    required this.notificationColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _buildCard(context, colorScheme),
        _buildDivider(colorScheme),
      ],
    );
  }

  Widget _buildCard(BuildContext context, ColorScheme colorScheme) {
    return Card(
      elevation: 0,
      color: notificationColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _handleCardTap(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNotificationIcon(colorScheme),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildNotificationContent(context, colorScheme),
                  ),
                  _buildMoreOptionsButton(context, colorScheme),
                ],
              ),
            ),
            if (!notification.seen!) _buildUnreadIndicator(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.notifications_outlined,
        color: colorScheme.onPrimaryContainer.withOpacity(0.7),
        size: 20,
      ),
    );
  }

  Widget _buildNotificationContent(
      BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notification.title!,
          style: AppStyles.textStyle16Black.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface.withOpacity(0.9),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          notification.body!,
          style: AppStyles.textStyle16.copyWith(
            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            height: 1.3,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        _buildTimestamp(context, colorScheme),
      ],
    );
  }

  Widget _buildTimestamp(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 14,
          color: colorScheme.onSurfaceVariant.withOpacity(0.5),
        ),
        const SizedBox(width: 4),
        Text(
          dateTimeFormat(notification.createdAt.toString(), 'h:mm a'),
          style: AppStyles.textStyle16.copyWith(
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildMoreOptionsButton(
      BuildContext context, ColorScheme colorScheme) {
    return PopupMenuButton(
      color: colorScheme.surface,
      icon: Icon(
        Icons.more_vert,
        color: colorScheme.onSurfaceVariant.withOpacity(0.7),
        size: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) => _buildPopupMenuItems(context, colorScheme),
      onSelected: (value) => _handlePopupMenuSelection(context, value),
    );
  }

  List<PopupMenuItem> _buildPopupMenuItems(
      BuildContext context, ColorScheme colorScheme) {
    return [
      PopupMenuItem(
        value: 'read',
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 18,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).read,
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(
              Icons.delete_outline,
              size: 18,
              color: colorScheme.error,
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).delete,
              style: TextStyle(color: colorScheme.error),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildUnreadIndicator(ColorScheme colorScheme) {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: colorScheme.outlineVariant.withOpacity(0.7),
      indent: 16,
      endIndent: 16,
    );
  }

  void _handleCardTap(BuildContext context) {
    context.push(
      "/notification_details",
      extra: notification,
    );
    if (!notification.seen!) {
      context.read<ReadNotificationCubit>().readNotification(notification.id!);
    }
  }

  void _handlePopupMenuSelection(BuildContext context, String value) {
    if (value == 'read') {
      context.read<ReadNotificationCubit>().readNotification(notification.id!);
    } else if (value == 'delete') {
      _showDeleteDialog(context);
    }
  }

  void _showDeleteDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    SmartDialog.show(
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: colorScheme.error,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).confirm_delete,
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ],
        ),
        content: Text(
          S.of(context).sure_delete_notification,
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
          FilledButton.tonal(
            onPressed: () {
              context
                  .read<ReadNotificationCubit>()
                  .deleteNotification(notification.id!);
              SmartDialog.dismiss();
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.errorContainer,
              foregroundColor: colorScheme.onErrorContainer,
            ),
            child: Text(S.of(context).delete),
          ),
        ],
      ),
    );
  }
}
