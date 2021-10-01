import 'package:flutter/material.dart';
import 'package:dfc_flutter/dfc_flutter.dart';

// --speed
// slowest, slower, normal, faster and fastest

enum AnimationSpeed {
  slowest,
  slower,
  normal,
  faster,
  fastest,
}

class AnimationSpeedMenuItem {
  AnimationSpeedMenuItem({this.title, this.speed});
  String title;
  AnimationSpeed speed;

  static AnimationSpeedMenuItem defaultMenuItem =
      AnimationSpeedMenuItem(title: 'normal', speed: AnimationSpeed.normal);

  static List<AnimationSpeedMenuItem> items = <AnimationSpeedMenuItem>[
    AnimationSpeedMenuItem(
        title: 'Slowest speed', speed: AnimationSpeed.slowest),
    AnimationSpeedMenuItem(title: 'Slower speed', speed: AnimationSpeed.slower),
    AnimationSpeedMenuItem(title: 'Normal speed', speed: AnimationSpeed.normal),
    AnimationSpeedMenuItem(title: 'Faster speed', speed: AnimationSpeed.faster),
    AnimationSpeedMenuItem(
        title: 'Fastest speed', speed: AnimationSpeed.fastest),
  ];
}

class AnimationSpeedMenu extends StatelessWidget {
  const AnimationSpeedMenu({
    @required this.onItemSelected,
    @required this.selectedItem,
  });

  final void Function(AnimationSpeedMenuItem) onItemSelected;
  final AnimationSpeedMenuItem selectedItem;

  Widget _menuButton(BuildContext context) {
    final Widget button = SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(
                selectedItem.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.arrow_drop_down,
              ),
            ),
          ],
        ),
      ),
    );

    final List<PopupMenuItem<AnimationSpeedMenuItem>> menuItems = [];

    for (final item in AnimationSpeedMenuItem.items) {
      menuItems.add(PopupMenuItem<AnimationSpeedMenuItem>(
        value: item,
        child: MenuItem(
          icon: const Icon(Icons.compare),
          name: item.title,
        ),
      ));
    }

    return PopupMenuButton<AnimationSpeedMenuItem>(
      itemBuilder: (context) {
        return menuItems;
      },
      onSelected: (selected) {
        onItemSelected(selected);
      },
      child: button,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _menuButton(context);
  }
}
