import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0, // hauteur fixe du container
      width: 100, // prendre toute la largeur de l'écran
      constraints: BoxConstraints(maxWidth: 300), // largeur maximale du container
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: 40.0,
            color: Colors.white,
            icon: Icon(Icons.home),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 40.0,
            color: Colors.white,
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 40.0,
            color: Colors.white,
            icon: Icon(Icons.info),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: CustomContainer(),
    ),
  ));
}
