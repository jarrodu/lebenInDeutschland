import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/models/bottom_navbar_item_model.dart';

class HomeBottomNavbarItemButton extends StatelessWidget {
  final BottomNavbarItemModel bottomNavbarItemModel;
  const HomeBottomNavbarItemButton(this.bottomNavbarItemModel, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => bottomNavbarItemModel.navigatePageName,
            )),
        icon: bottomNavbarItemModel.icon);
  }
}
