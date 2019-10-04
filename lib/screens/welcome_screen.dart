import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import 'package:flash_chat/Rounded_Button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    //animation = ColorTween(begin: Colors.blue,end: Colors.purple).animate
    // (controller);
    controller.forward();
//    animation.addStatusListener((status){
//      if (status == AnimationStatus.completed){
//        controller.reverse(from: 1.0);
//      }else if (status == AnimationStatus.dismissed){
//        controller.forward();
//      }
//    }
//  );
    controller.addListener(() {
      print(animation.value);
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
//                 Container(
//                    child: Image.asset('images/download.png'),
//                    alignment: Alignment.bottomCenter,
//                    ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 2.5,
                    child: Column(
                      children: <Widget>[
                        Image.asset('images/fb.png', scale: 5.0),
                        Text(
                          'Firebase',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo1.png'),
                    height: animation.value * 50,
                  ),
                ),
                Text(
                  'Chat',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 44,
                      fontStyle: FontStyle.normal),
                ),
              ],
            ),
            SizedBox(
              height: 28.0,
            ),
            new RoundedButton(
              colour: Color(0xFF3DDC84),
              title: 'SignIn',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            new RoundedButton(
              colour: Color(0xFF3DDC84),
              title: 'SignUp',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            Row(
              children: <Widget>[
//                 Container(
//                    child: Image.asset('images/download.png'),
//                    alignment: Alignment.bottomCenter,
//                    ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('images/download.png', scale: 2.0),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
