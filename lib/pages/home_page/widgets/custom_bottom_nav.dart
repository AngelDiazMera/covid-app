import 'package:flutter/material.dart';
import 'package:covserver/config/theme.dart';

class CustomButtonNavigationBar extends StatelessWidget {
  final Function onItemTapped;
  final int selectedIndex;

  const CustomButtonNavigationBar(
      {Key? key, required this.onItemTapped, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 10, blurRadius: 15),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).brightness == Brightness.dark
              ? applicationColors['lila']
              : applicationColors['light_purple'],
          // unselectedItemColor: Colors.black45,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? applicationColors['background_dark_2']
              : applicationColors['background_light_2'],
          currentIndex: selectedIndex,
          onTap: onItemTapped as void Function(int)?,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.coronavirus,
                size: 30,
              ),
              label: 'Síntomas',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Mi cuenta',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 30,
              ),
              label: 'Preferencias',
            ),
          ],
        ),
      ),
    );
  }
}
