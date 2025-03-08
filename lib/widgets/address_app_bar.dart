import 'package:flutter/material.dart';

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String address;
  final VoidCallback? onTap;

  const AddressAppBar({super.key, required this.address, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surface,
      title: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              color: theme.colorScheme.onSurface,
              size: 20,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                address,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.expand_more,
              color: theme.colorScheme.onSurface,
              size: 20,
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: theme.colorScheme.onSurface),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
