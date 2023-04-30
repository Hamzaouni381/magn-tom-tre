import 'package:flutter/material.dart';

class Draw extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // prend toute la largeur de l'écran
      constraints: BoxConstraints(maxWidth: 20), // largeur maximale de l'appbar
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          title: Container(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "hello"
                ),
                VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 2,
                  width: 10.0,
                  color: Colors.white,
                ),
                IconButton(
                  iconSize: 40.0,
                  color: Colors.white,
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
                VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 2,
                  width: 10.0,
                  color: Colors.white,
                ),
                IconButton(
                  iconSize: 40.0,
                  color: Colors.white,
                  icon: Icon(Icons.info),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

void main() {
  runApp(MaterialApp(
    home: Draw(),
  ));
}
