import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter DEMO',
      theme: ThemeData.dark(),
      home: const TextLearnView(),
    );

  }
}
class TextLearnView extends StatelessWidget{
  const TextLearnView({Key? key })  : super(key: key);
  Widget build (BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: LogoTextStyle()),
        backgroundColor: Colors.black54,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_circle_down_sharp),

      ),
      body: const Center(child:
      Text(
          'Eerenss\n' + 'FirstAppTryingAndChanging'
      )),
    );
  }
}
class LogoTextStyle extends StatelessWidget {
  const LogoTextStyle({Key? key })  : super(key: key);

  @override
    Widget build(BuildContext context) {
      return Text(
        'AGUM',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24.0,
          color: Colors.deepPurple,
          letterSpacing: 2.0,
          shadows: [
            Shadow(
              blurRadius: 2.0,
              color: Colors.black.withOpacity(0.3),
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      );
    }
  }

