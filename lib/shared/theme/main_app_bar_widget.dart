import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const MainAppBar(
      {super.key,
      required this.title,
      this.actions,
      this.showBackButton = false});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: LeafLoreColors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: LeafLoreColors.leafWhite,
          systemNavigationBarColor: LeafLoreColors.leafWhite),
      leading: widget.showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 24.0),
          ),
        ],
      ),
      actions: widget.actions,
      // shape: const RoundedRectangleBorder(
      //     // side: BorderSide(color: LeafLoreColors.tiffanyBlue, width: 2.0),
      //     borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(20.0),
      //         bottomRight: Radius.circular(20.0))),
    );
  }
}
