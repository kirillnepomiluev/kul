import 'package:flutter/material.dart';

import 'buildAppBar.dart';


Scaffold buildMyScaffold(BuildContext context, Widget body, String title,
    {int bottomItemIndex = 0,
      bool isColorBlack = true ,
      bool isAppbar = true,
      int indexdrawer = 0,
      bool isNeedDrawer = true,
      bool isNeedBottomMenu = true,
      bool isNeedBottomBar = false,
      bool actionsAppBar = true}) {
  return Scaffold(
    appBar: isAppbar ? buildAppBar(context, title)        : null,
    backgroundColor: isColorBlack? Theme.of(context).scaffoldBackgroundColor : Colors.black87,
    body: body,
  );
}
