import 'package:plot/HEATMAP.dart';

import 'logoanimation.dart';
import 'slogananimation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'heatmap2.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(child: Logo()),
              Container(
                height: 160,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TypeWrite(
                    textScaleFactor: 1,
                    seconds: 5,
                    word: 'Your personal \n magnetic field',
                    style: GoogleFonts.spaceMono(
                      letterSpacing: 1.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 28.0,
                    ),

                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: FractionallySizedBox(
                        alignment: Alignment.center,
                        widthFactor: 1.0,
                        child: Builder(
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HeatMapApp()));
                            },
                            child: Text('get started',style:TextStyle(fontSize:25)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )),
    );
  }
}

void main() {
  runApp(LandingPage());}