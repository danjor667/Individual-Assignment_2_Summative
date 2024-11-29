import 'package:flutter/material.dart';

class Recherche {
  static affiche(Widget vue, BuildContext context) {
    //
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      showDragHandle: true,
      context: context,
      builder: (c) {
        return vue;
      },
    );
  }
}
