import 'package:flutter/material.dart';
import 'package:leben_in_deutschland/extensions/context_extension.dart';
import 'package:leben_in_deutschland/models/home_menu_item_model.dart';

class HomeMenuItemButton extends StatelessWidget {
  final HomeMenuItemModel _homeMenuItemModel;
  const HomeMenuItemButton(this._homeMenuItemModel, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: context.theme.elevatedButtonTheme.style!.copyWith(
          fixedSize: MaterialStateProperty.all(Size(context.width, context.highValue)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _homeMenuItemModel.navigatePageName,
            )),
        child: Text(
          _homeMenuItemModel.title,
          style: context.theme.primaryTextTheme.headline5,
        ));
  }
}
