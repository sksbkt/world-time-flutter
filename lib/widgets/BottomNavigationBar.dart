import 'package:flutter/material.dart';

class ShowBottomNavBar extends StatelessWidget {
  const ShowBottomNavBar({
    Key? key,
    required this.context,
    // required this.onTap,
  }) : super(key: key);

  // final void Function(int) onTap;
  // final int selectedIndex;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.grey.shade800,
      unselectedItemColor: Colors.grey.shade500,
      onTap: (index) => changePage(index, context),
      currentIndex: 1,
      showUnselectedLabels: false,
      iconSize: 26,
      selectedFontSize: 15,
      items: [
        BottomNavigationBarItem(label: 'contacts', icon: Icon(Icons.contacts)),
        BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            label: 'shcedules', icon: Icon(Icons.schedule_rounded))
      ],
    );
  }

  void changePage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/account');
        break;
      case 1:
        Navigator.pushNamed(context, '/home');
        break;
      case 2:
        Navigator.pushNamed(context, '/calendar');
        break;
    }
  }
}
