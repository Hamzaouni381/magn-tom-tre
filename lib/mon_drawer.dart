import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: 70.0,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Divider(color: Colors.white, thickness: 2.0,indent: 9,endIndent: 9,height: 60,), // Ajout de la ligne de séparation
              IconButton(
                iconSize: 55,
                color: Colors.white,
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
              Divider(color: Colors.white, thickness: 2.0,indent: 9,endIndent: 9,height: 60,), // Ajout de la ligne de séparation
              IconButton(
                iconSize: 55,
                color: Colors.white,
                icon: Icon(Icons.graphic_eq_rounded),
                onPressed: () {},
              ),
              Divider(color: Colors.white, thickness: 2.0,indent: 9,endIndent: 9,height: 60,),
              IconButton(
                iconSize: 55,
                color: Colors.white,
                icon: Icon(Icons.reset_tv),
                onPressed: () {},
              ),
              Divider(color: Colors.white, thickness: 2.0,indent: 9,endIndent: 9,height: 60,),

              IconButton(
                iconSize: 55,
                color: Colors.white,
                icon: Icon(Icons.info),
                onPressed: () {},
              ),
              Divider(color: Colors.white, thickness: 2.0,indent: 9,endIndent: 9,height: 60,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(60.0, double.infinity);
}

void main() {
  runApp(CustomAppBar());
}
