import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() {runApp( MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute:WelcomeScreen.id ,
      routes: {
        WelcomeScreen.id:(context) => WelcomeScreen(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        ChatScreen.id:(context) => ChatScreen(),
      },
      )
    );
  }





// FlashChat());

// class FlashChat extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
// //    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
// //      statusBarColor: Colors.transparent,
// //      statusBarBrightness: Brightness.light,
// //    ));

//     return





















